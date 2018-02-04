;;; ox-ipynb.el --- Convert an org-file to an ipynb.  -*- lexical-binding: t; -*-

;; Copyright(C) 2017 John Kitchin

;; Author: John Kitchin <jkitchin@andrew.cmu.edu>
;; URL: https://github.com/jkitchin/ox-ipynb/ox-ipynb.el
;; Version: 0.1
;; Keywords: org-mode
;; Package-Requires: ((emacs "25") (org "8.2"))

;; This file is not currently part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;; It is possible to set metadata at the notebook level using
;; #+ox-ipynb-keyword-metadata: key1 key2
;; This will use store key:value pairs in
;; the notebook metadata section, in an org section.
;;
;; You can force a new cell to be created with the org-directive #+ipynb-newcell
;;
;; This exporter supports ipython and R Juypter notebooks. Other languages could
;; be supported, but you need to add a kernelspec to `ox-ipynb-kernelspecs' and
;; the language info to `ox-ipynb-language-infos'.
;;
;; The org-file is parsed into a list of cells. Each cell is either a markdown
;; cell or a code cell (with results). Headlines are parsed to their own cells
;; to enable collapsible headings to work nicely.
;;
;; You can export an org-file to a buffer, file or file and open.

;;; Code:
(require 'cl)
(require 'ox-md)
(require 'ox-org)


(defvar ox-ipynb-kernelspecs '((ipython . (kernelspec . ((display_name . "Python 3")
                                                         (language . "python")
                                                         (name . "python3"))))
                               (R . (kernelspec . ((display_name . "R")
                                                   (language . "R")
                                                   (name . "ir"))))
                               (julia . (kernelspec . ((display_name . "Julia 0.6.0")
						       (language . "julia")
						       (name . "julia-0.6")))))
  "Kernelspec metadata for different kernels.")


(defvar ox-ipynb-language-infos
  '((ipython . (language_info . ((codemirror_mode . ((name . ipython)
                                                     (version . 3)))
                                 (file_extension . ".py")
                                 (mimetype . "text/x-python")
                                 (name . "python")
                                 (nbconvert_exporter . "python")
                                 (pygments_lexer . "ipython3")
                                 (version . "3.5.2"))))
    (R . (language_info . ((codemirror_mode . "r")
                           (file_extension . ".r")
                           (mimetype . "text/x-r-source")
                           (name . "R")
                           (pygments_lexer . "r")
                           (version . "3.3.2"))))
    (julia . (language_info . ((codemirror_mode . "julia")
                               (file_extension . ".jl")
                               (mimetype . "text/x-julia")
                               (name . "julia")
                               (pygments_lexer . "julia")
                               (version . "0.6.0")))))
  "These get injected into notebook metadata.
They are reverse-engineered from existing notebooks.")


(defun ox-ipynb-export-code-cell (src-result)
  "Return a code cell for the org-element in the car of SRC-RESULT.
The cdr of SRC-RESULT is the end position of the results."
  (let* ((src-block (car src-result))
         (results-end (cdr src-result))
         (results (org-no-properties (car results-end)))
         (output-cells '())
         img-path img-data
         (start 0)
         end
         block-start block-end
         html
         latex)

    ;; Handle inline images first
    (while (string-match "\\[\\[file:\\(.*?\\)\\]\\]" (or results "") start)
      (setq start (match-end 0))
      (setq img-path (match-string 1 results)
            img-data (base64-encode-string
                      (encode-coding-string
                       (with-temp-buffer
                         (insert-file-contents img-path)
                         (buffer-string))
                       'binary)
                      t))
      (setq output-cells
	    (append output-cells
		    `((data . ((image/png . ,img-data)
			       ("text/plain" . "<matplotlib.figure.Figure>")))
		      (metadata . ,(make-hash-table))
		      (output_type . "display_data")))))
    ;; now remove the inline images and put the results in.
    (setq results (s-trim (replace-regexp-in-string "\\[\\[file:\\(.*?\\)\\]\\]" ""
                                                    (or results ""))))

    ;; Check for HTML cells. I think there can only be one I don't know what the
    ;; problem is, but I can't get the match-end functions to work correctly
    ;; here. Its like the match-data is not getting updated.
    (when (string-match "#\\+BEGIN_EXPORT HTML" (or results ""))
      (setq block-start (s-index-of "#+BEGIN_EXPORT HTML" results)
            start (+ block-start (length "#+BEGIN_EXPORT HTML\n")))

      ;; Now, get the end of the block.
      (setq end (s-index-of "#+END_EXPORT" results)
            block-end (+ end (length "#+END_EXPORT")))

      (setq html (substring results start end))

      ;; remove the old output.
      (setq results (concat (substring results 0 block-start)
                            (substring results block-end)))
      (message "html: %s\nresults: %s" html results)
      (setq output-cells (append
			  output-cells `((data . ((text/html . ,html)
						  ("text/plain" . "HTML object")))
					 (metadata . ,(make-hash-table))
					 (output_type . "display_data")))))

    ;; Handle latex cells
    (when (string-match "#\\+BEGIN_EXPORT latex" (or results ""))
      (setq block-start (s-index-of "#+BEGIN_EXPORT latex" results)
            start (+ block-start (length "#+BEGIN_EXPORT latex\n")))

      ;; Now, get the end of the block.
      (setq end (s-index-of "#+END_EXPORT" results)
            block-end (+ end (length "#+END_EXPORT")))

      (setq latex (substring results start end))

      ;; remove the old output.
      (setq results (concat (substring results 0 block-start)
                            (substring results block-end)))

      (setq output-cells (append
			  output-cells
			  `((data . ((text/latex . ,latex)
				     ("text/plain" . "Latex object")))
			    (metadata . ,(make-hash-table))
			    (output_type . "display_data")))))

    ;; output cells
    (unless (string= "" results)
      (setq output-cells (append `(((name . "stdout")
                                    (output_type . "stream")
                                    (text . ,results)))
                                 output-cells)))


    `((cell_type . "code")
      (execution_count . 1)
      ;; the hashtable trick converts to {} in json. jupyter can't take a null here.
      (metadata . ,(make-hash-table))
      (outputs . ,(if (null output-cells)
                      ;; (vector) json-encodes to  [], not null which
                      ;; jupyter does not like.
                      (vector)
                    (vconcat output-cells)))
      (source . ,(vconcat
                  (list (s-trim (car (org-export-unravel-code src-block)))))))))


(defun ox-ipynb-filter-latex-fragment (text _ _)
  "Export org latex fragments in TEXT for ipynb markdown.
Latex fragments come from org as \(fragment\) for inline math or
\[fragment\] for displayed math. Convert to $fragment$
or $$fragment$$ for ipynb."
  ;; \\[frag\\] or \\(frag\\) are also accepted by ipynb markdown (need double backslash)
  (setq text (replace-regexp-in-string
              "\\\\\\[" "$$"
              (replace-regexp-in-string "\\\\\\]" "$$" text)))
  (replace-regexp-in-string "\\\\(\\|\\\\)" "$" text))


(defun ox-ipynb-filter-link (text _ _)
  "Make a link in TEXT into markdown.
For some reason I was getting angle brackets in them I wanted to remove.
This only fixes file links with no description I think."
  (if (s-starts-with? "<" text)
      (let ((path (substring text 1 -1)))
        (format "[%s](%s)" path path))
    text))


(defun ox-ipynb-export-markdown-cell (s)
  "Return the markdown cell for the string S."
  (let* ((org-export-filter-latex-fragment-functions '(ox-ipynb-filter-latex-fragment))
         (org-export-filter-link-functions '(ox-ipynb-filter-link))
         (org-export-filter-keyword-functions '(ox-ipynb-keyword-link))
         ;; I overwrite the org function here because it does not give the right
         ;; levels otherwise. This one outputs exactly the level that is listed.
         (md (cl-letf (((symbol-function 'org-export-get-relative-level)
                        (lambda (headline info) (org-element-property :level headline))))
               (org-export-string-as
                s
                'md t '(:with-toc nil :with-tags nil)))))
    (if (not (string= "" (s-trim md)))
        `((cell_type . "markdown")
          (metadata . ,(make-hash-table))
          (source . ,(vconcat
                      (list md))))
      nil)))


(defun ox-ipynb-export-keyword-cell ()
  "Make a markdown cell containing org-file keywords and values."
  (let* ((all-keywords (org-element-map (org-element-parse-buffer)
                           'keyword
                         (lambda (key)
                           (cons (org-element-property :key key)
                                 (org-element-property :value key)))))
         (ipynb-keywords (cdr (assoc "OX-IPYNB-KEYWORD-METADATA" all-keywords)))
         (include-keywords (mapcar 'upcase (split-string (or ipynb-keywords ""))))
         (keywords (loop for key in include-keywords
                         if (assoc key all-keywords)
                         collect (cons key (or (cdr (assoc key all-keywords)) "")))))
    
    (setq keywords
          (loop for (key . value) in keywords
                collect
                (format "- %s: %s\n"
                        key
                        (replace-regexp-in-string
                         "<\\|>" ""
                         (or value "")))))
    (when keywords
      `((cell_type . "markdown")
        (metadata . ,(make-hash-table))
        (source . ,(vconcat keywords))))))


(defun ox-ipynb-get-language ()
  "Get the language for the exporter.
We assume the first code-block contains the language you want.
Python is the default."
  (intern (or (org-element-map (org-element-parse-buffer)
                  'src-block
                (lambda (src)
                  (org-element-property :language src))
                nil t)
              "ipython")))


(defun ox-ipynb-split-text (s)
  "Given a string S, split it into substrings.
Each heading is its own string. Also, split on #+ipynb-newcell.
Empty strings are eliminated."
  (let* ((s1 (s-slice-at org-heading-regexp s))
         ;; split headers out
         (s2 (loop for string in s1
                   append
                   (if (string-match org-heading-regexp string)
                       (let ((si (split-string string "\n")))
                         (list (car si)
                               (mapconcat 'identity (cdr si) "\n")))
                     (list string))))
         (s3 (loop for string in s2
                   append
                   (split-string string "#\\+ipynb-newcell"))))

    s3))


(defun ox-ipynb-export-to-buffer ()
  "Export the current buffer to ipynb format in a buffer.
Only ipython source blocks are exported as code cells. Everything
else is exported as a markdown cell. The output is in *ox-ipynb*."

  ;; This is a hack to remove empty Results. I think this is a bug in org-mode,
  ;; that it exports empty results to have a nil in them without a \n, which
  ;; causes this exporter to fail to find them.
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "#\\+RESULTS:
:RESULTS:
nil:END:"  nil t)
      (replace-match "")))

  ;; this is a temporary hack to fix a bug in org-mode that puts a nil at the
  ;; end of exported dynamic blocks. <2017-05-19 Fri>
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\(#\\+BEGIN:.*\\)nil"  nil t)
      (replace-match "\\1")))


  ;; preprocess some org-elements that need to be exported to strings prior to
  ;; the rest. This is not complete. Do these in reverse so the buffer positions
  ;; don't get changed in the parse tree.
  (mapc (lambda (elm)
          (setf (buffer-substring (org-element-property :begin elm)
                                  (org-element-property :end elm))
                (org-md-quote-block elm
                                    (buffer-substring
                                     (org-element-property :contents-begin elm)
                                     (org-element-property :contents-end elm))
                                    nil)))
        (reverse (org-element-map (org-element-parse-buffer) 'quote-block 'identity)))

  (mapc (lambda (elm)
          (setf (buffer-substring (org-element-property :begin elm)
                                  (org-element-property :end elm))
                (org-md-export-block elm
                                     (buffer-substring
                                      (org-element-property :contents-begin elm)
                                      (org-element-property :contents-end elm))
                                     nil)))
        (reverse (org-element-map (org-element-parse-buffer) 'dynamic-block 'identity)))



  ;; Now we parse the buffer.
  (let* ((cells (if (ox-ipynb-export-keyword-cell) (list (ox-ipynb-export-keyword-cell)) '()))
         (ox-ipynb-language (ox-ipynb-get-language))
         (metadata `(metadata . ((org . ,(let* ((all-keywords (org-element-map (org-element-parse-buffer)
                                                                  'keyword
                                                                (lambda (key)
                                                                  (cons (org-element-property :key key)
                                                                        (org-element-property :value key)))))
                                                (ipynb-keywords (cdr (assoc "OX-IPYNB-KEYWORD-METADATA" all-keywords)))
                                                (include-keywords (mapcar 'upcase (split-string (or ipynb-keywords ""))))
                                                (keywords (loop for key in include-keywords
                                                                collect (assoc key all-keywords))))
                                           keywords))
                                 ,(cdr (assoc ox-ipynb-language ox-ipynb-kernelspecs))
                                 ,(cdr (assoc ox-ipynb-language ox-ipynb-language-infos)))))
         (ipynb (or (and (boundp 'export-file-name) export-file-name)
                    (concat (file-name-base (buffer-file-name)) ".ipynb")))
         src-blocks
         src-results
         current-src
         result
         result-end
         end
         data)

    (setq src-blocks (org-element-map (org-element-parse-buffer) 'src-block
                       (lambda (src)
                         (when (string= (symbol-name ox-ipynb-language)
                                        (org-element-property :language src))
                           src))))

    ;; Get a list of (src . results). These are only source blocks and
    ;; corresponding results. We assume that before, between and after src
    ;; blocks there are markdown cells.
    (setq src-results
          (loop for src in src-blocks
                with result=nil
                do
                (setq result
                      (save-excursion
                        (goto-char (org-element-property :begin src))
                        (let ((location (org-babel-where-is-src-block-result nil nil))
                              start end
                              result-content)
                          (when location
                            (save-excursion
                              (goto-char location)
                              (when (looking-at
                                     (concat org-babel-result-regexp ".*$"))
                                (setq start (1- (match-beginning 0))
                                      end (progn (forward-line 1) (org-babel-result-end))
                                      result-content (buffer-substring-no-properties
                                                      start end))
                                ;; clean up the results a little. This gets rid
                                ;; of the RESULTS markers for output and drawers
                                (loop for pat in '("#\\+RESULTS:"
                                                   "^: " "^:RESULTS:\\|^:END:")
                                      do
                                      (setq result-content (replace-regexp-in-string
                                                            pat
                                                            ""
                                                            result-content)))
                                ;; the results and the end of the results.
                                ;; we use the end later to move point.
                                (cons (s-trim result-content) end)))))))
                collect
                (cons src result)))

    (setq current-source (pop src-results))

    ;; First block before a src is markdown, unless it happens to be empty.
    (if (car current-source)
        (unless (string= "" (s-trim
                             (buffer-substring-no-properties
                              (point-min)
                              (org-element-property :begin (car current-source)))))
          (let ((text (buffer-substring-no-properties
                       (point-min)
                       (org-element-property :begin (car current-source)))))
            (loop for s in (ox-ipynb-split-text text)
                  unless (string= "" (s-trim s))
                  do
                  (when-let ((md (ox-ipynb-export-markdown-cell s)))
                    (push md cells)))))
      ;; this is a special case where there are no source blocks, and the whole
      ;; document is a markdown cell.
      (let ((text (buffer-substring-no-properties (point-min) (point-max))))
        (loop for s in (ox-ipynb-split-text text)
              unless (string= "" (s-trim s))
              do
              (when-let ((md (ox-ipynb-export-markdown-cell s)))
                (push md cells)))))

    (while current-source
      ;; add the src cell
      (push (ox-ipynb-export-code-cell current-source) cells)
      (setq result-end (cdr current-source)
            result (car result-end)
            result-end (cdr result-end))

      (setq end (max
                 (or result-end 0)
                 (org-element-property :end (car current-source))))

      (setq current-source (pop src-results))

      (if current-source
          (when (not (string= "" (s-trim (buffer-substring
                                          end
                                          (org-element-property
                                           :begin
                                           (car current-source))))))
            (let ((text (buffer-substring-no-properties
                         end (org-element-property :begin
                                                   (car current-source)))))
              (loop for s in (ox-ipynb-split-text text)
                    unless (string= "" s)
                    do
                    (when-let ((md (ox-ipynb-export-markdown-cell (s-trim s))))
                      (push md cells)))))
        ;; on last block so add rest of document
        (let ((text (buffer-substring-no-properties end (point-max))))
          (loop for s in (ox-ipynb-split-text text)
                unless (string= "" s)
                do
                (when-let ((md (ox-ipynb-export-markdown-cell (s-trim s))))
                  (push md cells))))))

    (setq data (append
                `((cells . ,(reverse cells)))
                (list metadata)
                '((nbformat . 4)
                  (nbformat_minor . 0))))

    ;; Put the json into a buffer
    (with-current-buffer (get-buffer-create "*ox-ipynb*")
      (erase-buffer)
      (insert (json-encode data)))

    (switch-to-buffer "*ox-ipynb*")
    (setq-local export-file-name ipynb)
    (get-buffer "*ox-ipynb*")))


(defun ox-ipynb-nbopen (fname)
  "Open FNAME in jupyter notebook."
  (interactive  (list (read-file-name "Notebook: ")))
  (shell-command (format "nbopen \"%s\" &" fname)))


;; * export menu
(defun ox-ipynb-export-to-ipynb-buffer (&optional async subtreep visible-only
                                                  body-only info)
  "Export the current buffer to an ipynb in a new buffer.
Optional argument ASYNC to asynchronously export.
Optional argument SUBTREEP to export current subtree.
Optional argument VISIBLE-ONLY to only export visible content.
Optional argument BODY-ONLY export only the body.
Optional argument INFO is a plist of options."
  (let ((ipynb (or (when (boundp 'export-file-name) export-file-name)
                   (concat (file-name-base (buffer-file-name)) ".ipynb")))
        buf)
    (org-org-export-as-org async subtreep visible-only body-only info)
    (with-current-buffer "*Org ORG Export*"
      (setq-local export-file-name ipynb)

      (setq buf (ox-ipynb-export-to-buffer))
      (with-current-buffer buf
        (setq-local export-file-name ipynb))
      (prog1
          buf
        (kill-buffer "*Org ORG Export*")))))


(defun ox-ipynb-export-to-ipynb-file (&optional async subtreep visible-only body-only info)
  "Export current buffer to a file.
Optional argument ASYNC to asynchronously export.
Optional argument SUBTREEP to export current subtree.
Optional argument VISIBLE-ONLY to only export visible content.
Optional argument BODY-ONLY export only the body.
Optional argument INFO is a plist of options."
  (with-current-buffer (ox-ipynb-export-to-ipynb-buffer async subtreep visible-only body-only info)
    (let* ((efn export-file-name)
           (buf (find-file-noselect efn) ))
      (write-file efn)
      (with-current-buffer buf
        (setq-local export-file-name efn))
      (kill-buffer buf)
      efn)))


(defun ox-ipynb-export-to-ipynb-file-and-open (&optional async subtreep visible-only body-only info)
  "Export current buffer to a file and open it.
Optional argument ASYNC to asynchronously export.
Optional argument SUBTREEP to export current subtree.
Optional argument VISIBLE-ONLY to only export visible content.
Optional argument BODY-ONLY export only the body.
Optional argument INFO is a plist of options."
  (let* ((async-shell-command-buffer 'confirm-kill-buffer)
         (fname (expand-file-name
                 (ox-ipynb-export-to-ipynb-file async subtreep visible-only body-only info))))
    ;; close the .ipynb buffer.
    (kill-buffer (find-file-noselect fname))
    (async-shell-command
     (format "jupyter notebook \"%s\"" fname))))


(org-export-define-derived-backend 'jupyter-notebook 'org
  :menu-entry
  '(?n "Export to jupyter notebook"
       ((?b "to buffer" ox-ipynb-export-to-ipynb-buffer)
        (?n "to notebook" ox-ipynb-export-to-ipynb-file)
        (?o "to notebook and open" ox-ipynb-export-to-ipynb-file-and-open))))


(provide 'ox-ipynb)

;;; ox-ipynb.el ends here
