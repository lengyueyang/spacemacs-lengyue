;;; ------------------------------------------
;;; Do not edit this file. It was tangled from
;;; an org file.
;;; ------------------------------------------

(require 'req-package)

(defun open-my-init-file()
  (interactive)
  (find-file "~/.spacemacs.d/lengyueyang.org"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

(require 'chinese-yasdcv)
(define-key global-map (kbd "<f3>") 'yasdcv-translate-at-point)

(define-key global-map (kbd "<f8>") 'flyspell-correct-previous-word-generic)

(spacemacs/declare-prefix "om" "Bookmark")
(spacemacs/set-leader-keys "oms" 'bookmark-set)
(spacemacs/set-leader-keys "omr" 'bookmark-rename)
(spacemacs/set-leader-keys "omd" 'bookmark-delete)
(spacemacs/set-leader-keys "omj" 'counsel-bookmark)

(when (configuration-layer/layer-usedp 'markdown)
  (setq auto-mode-alist (cons '("\\.text$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.md$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.mdown$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.mdt$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.markdown$" . gfm-mode) auto-mode-alist)))

(setq lengyueyang-configuration-path "~/.spacemacs.d/")

(defun lengyueyang/load-my-layout ()
  (interactive)
  (persp-load-state-from-file (concat lengyueyang-configuration-path "lengyueyang")))

(defun lengyueyang/save-my-layout ()
  (interactive)
  (persp-save-state-to-file (concat lengyueyang-configuration-path "lengyueyang")))

(spacemacs/declare-prefix "ol" "Layout-lengyueyang")
(spacemacs/set-leader-keys "oll" 'lengyueyang/load-my-layout)
(spacemacs/set-leader-keys "ols" 'lengyueyang/save-my-layout)

;;(defun zilongshanren-misc/post-init-persp-mode ()
;;  (setq persp-kill-foreign-buffer-action 'kill)
;;  (setq persp-lighter nil)
;;  (when (fboundp 'spacemacs|define-custom-layout)
;;    (spacemacs|define-custom-layout "@Cocos2D-X"
;;      :binding "c"
;;      :body
;;      (find-file "~/cocos2d-x/cocos/ui/UIWidget.cpp")
;;      (split-window-right)
;;      (find-file "~/cocos2d-x/cocos/cocos2d.cpp"))))

(global-set-key (kbd "<f5>") 'deft)
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory "~/Emacs-lengyue/Wiki-lengyue")

(setq user-full-name "lengyuyang"
      user-mail-address "maoxiaoweihl@gmail.com")

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

(req-package hungry-delete
  :init (global-hungry-delete-mode))

(spacemacs//set-monospaced-font "WenQuanYi Micro Hei Mono" "WenQuanYi Micro Hei Mono" 16 20)

(defun indent-whole-buffer ()
  "Indent whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

(defun quick-folding-source ()
  "Use emacs buildin easy to folding code."
  (interactive)
  (set-selective-display
   (if selective-display nil 1)))

(defun insert-U200B-char ()
  "Insert <U200B> char, this character is nice use in org-mode."
  (interactive)
  (insert "\ufeff"))

(defun insert-empty-line ()
  "Insert an empty line after current line and position cursor on newline."
  (interactive)
  (move-end-of-line nil)
  (open-line 1)
  (next-line 1))

(defun file-reopen-as-root ()
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun set-file-executable()
  "Add executable permissions on current file."
  (interactive)
  (when (buffer-file-name)
    (set-file-modes buffer-file-name
                    (logior (file-modes buffer-file-name) #o100))
    (message (concat "Made " buffer-file-name " executable"))))

(defun clone-file-and-open (filename)
  "Clone the current buffer writing it into FILENAME and open it"
  (interactive "FClone to file: ")
  (save-restriction
    (widen)
    (write-region (point-min) (point-max) filename nil nil nil 'confirm))
  (find-file filename))

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq revert-without-query '(".*")) ;; disable revert query

(req-package yasnippet
  :init (yas-global-mode 1)
  :mode ("emacs.+/snippets/" . snippet-mode)
  :config
  (progn
    (setq yas/prompt-functions '(yas-dropdown-prompt
                                 yas-completing-prompt
                                 yas-ido-prompt))

    (setq yas/snippet-dirs (concat user-emacs-directory "snippets"))))

(eval-after-load 'yasnippet
  '(progn
     (defadvice yas-expand (around major-mode-expand activate)
       "Try to complete a structure template before point like org-mode does.
  This looks for strings like \"<e\" on an otherwise empty line and
  expands them.
  Before use this function, you must setup `major-mode-name'-expand-alist variable.

  Take emacs-lisp-mode as example, if you wand to use <r to expand your snippet `require'
  in yasnippet, you muse setup the emacs-lisp-mode-expand-alist variable.

   (setq emacs-lisp-expand-alist '((\"r\" . \"require\")))"
       (let* ((l (buffer-substring (point-at-bol) (point)))
              (expand-symbol (intern (concat (symbol-name major-mode) "-expand-alist")))
              (expand-alist (if (boundp expand-symbol) (symbol-value expand-symbol) nil))
              a)
         (when (and (looking-at "[ \t]*$")
                    (string-match "^[ \t]*<\\([a-zA-Z]+\\)$" l)
                    (setq a (assoc (match-string 1 l) expand-alist)))
           (backward-delete-char (1+ (length (car-safe a))))
           (if (symbolp (cdr-safe a))
               (funcall (cdr-safe a))
             (insert (cdr-safe a)))
           t)
         ad-do-it))
     ))

(defun eval-buffer-until-error ()
  "Evaluate emacs buffer until error occured."
  (interactive)
  (goto-char (point-min))
  (while t (eval (read (current-buffer)))))

(setq org-startup-indented t)

(defun org-mode-my-init ()
  (define-key org-mode-map (kbd "×") (kbd "*"))
  ;;(define-key org-mode-map (kbd "－") (kbd "-"))
  (define-key org-mode-map (kbd "（") (kbd "("))
  (define-key org-mode-map (kbd "）") (kbd ")"))
  )
(add-hook 'org-mode-hook 'org-mode-my-init)

(eval-after-load 'org
  '(progn
     (setq org-columns-default-format "%50ITEM(Task) %CATEGORY %SCHEDULED %5Effort %5CLOCKSUM %PRIORITY")
     (setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                         ("STYLE_ALL" . "habit"))))
     )
  )

(defun lengyueyang/org-ispell ()
  "Configure `ispell-skip-region-alist' for `org-mode'."
  (make-local-variable 'ispell-skip-region-alist)
  (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
  (add-to-list 'ispell-skip-region-alist '("~" "~"))
  (add-to-list 'ispell-skip-region-alist '("=" "="))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC")))
(add-hook 'org-mode-hook #'lengyueyang/org-ispell)

(defun lengyueyang/post-init-org-bullets ()
  (setq org-bullets-bullet-list '("☰" "☷" "⋗" "⇀")))
(add-hook 'org-mode-hook #'lengyueyang/post-init-org-bullets)

(require 'org-notify)
(org-notify-start)
(org-notify-add 'appt
                '(:time "-1s" :period "20s" :duration 10
                        :actions (-message -ding))
                '(:time "15m" :period "2m" :duration 100
                        :actions -notify)
                '(:time "2h" :period "10m" :actions -message)
                '(:time "3d" :period "12h" :actions -message)
                '(:time "7d" :period "24h" :actions -message)
                '(:time "30d" :actions -email))

(defun notify-osx (title message)
  (call-process "gol"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-sender" "org.gnu.Emacs"
                "-message" message
                "-activate" "oeg.gnu.Emacs"))
(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            (notify-osx "Pomodoro completed!" "Time for a break.")))
(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()
            (notify-osx "Pomodoro Short Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-long-break-finished-hook
          (lambda ()
            (notify-osx "Pomodoro Long Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (notify-osx "Pomodoro Killed" "One does not simply kill a pomodoro!")))
;;  (add-hook 'org-pomodoro-finished-hook
;;  (lambda ()
;;  (lengyueyang//org-notify "Pomodoro completed!" "Time for a break.")))
;;(add-hook 'org-pomodoro-break-finished-hook
;;  (lambda ()
;;  (lengyueyang//org-notify "Pomodoro Short Break Finished" "Ready for Another?")))
;;(add-hook 'org-pomodoro-long-break-finished-hook
;;  (lambda ()
;;  (lengyueyang//org-notify "Pomodoro Long Break Finished" "Ready for Another?")))
;;(add-hook 'org-pomodoro-killed-hook
;;  (lambda ()
;;  (lengyueyang//org-notify "Pomodoro Killed" "One does not simply kill a pomodoro!")))

(eval-after-load 'org
  '(progn
     (setq org-agenda-dir "~/Emacs-lengyue/GTD-lengyue")
     (setq org-agenda-file-gtd (expand-file-name "GTD-lengyue.org" org-agenda-dir))
     (setq org-agenda-files `(,org-agenda-file-gtd))

     (setq org-default-notes-file org-agenda-file-gtd)
     (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n)" "|"  "DONE(d)")
            (sequence "WAITING(w@/!)" "SOMEDAY(s)" "|" "HOLD(h@/!)" "CANCELLED(c@/!)")
            (sequence "INBOX(i)" "|" "NOTE(e)" "PHONE(p)" "MEETING(m)")
            (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))
     (setq org-refile-targets
           '(("GTD-lengyue.org" :maxlevel . 1)))
     (setq org-log-into-drawer t)
     (setq org-agenda-custom-commands
        '(
          ("i" "Inbox" todo "INBOX")
          ("h" "Holdtodo" todo "HOLD")
          ("e" "Note" todo "NOTE")
          ("s" "Someday/Maybe" todo "SOMEDAY")
          ("b" "Blog" tags-todo "BLOG")
          ("w" . " 任务安排 ")
          ("wa" " 重要且紧急的任务 " tags-todo "+PRIORITY=\"A\"")
          ("wb" " 重要且不紧急的任务 " tags-todo "+PRIORITY=\"B\"")
          ("wc" " 不重要且紧急的任务 " tags-todo "+PRIORITY=\"C\"")
          ("p" . " 项目安排 ")
          ("W" "Weekly Review"
           ((stuck "");; review stuck projects as designated by org-stuck-projects
            (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
            )))))
  )

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)  ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook'org-after-todo-statistics-hook 'org-summary-todo)

  ;;used by org-clock-sum-today-by-tags
(defun filter-by-tags ()
    (let ((head-tags (org-get-tags-at)))
      (member current-tag head-tags)))


(defun org-clock-sum-today-by-tags (timerange &optional tstart tend noinsert)
    (interactive "P")
    (let* ((timerange-numeric-value (prefix-numeric-value timerange))
           (files (org-add-archive-files (org-agenda-files)))
           (include-tags'("PROG" "EMACS" "DREAM" "WRITING" "MEETING" "BLOG" "LIFE" "PROJECT"))
           (tags-time-alist (mapcar (lambda (tag) `(,tag . 0)) include-tags))
           (output-string "")
           (tstart (or tstart
                       (and timerange (equal timerange-numeric-value 4) (- (org-time-today) 86400))
                       (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "Start Date/Time:"))
                       (org-time-today)))
           (tend (or tend
                     (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "End Date/Time:"))
                     (+ tstart 86400)))
           h m file item prompt donesomething)
      (while (setq file (pop files))
        (setq org-agenda-buffer (if (file-exists-p file)
                                    (org-get-agenda-file-buffer file)
                                  (error "No such file %s" file)))
        (with-current-buffer org-agenda-buffer
          (dolist (current-tag include-tags)
            (org-clock-sum tstart tend'filter-by-tags)
            (setcdr (assoc current-tag tags-time-alist)
                    (+ org-clock-file-total-minutes (cdr (assoc current-tag tags-time-alist)))))))
      (while (setq item (pop tags-time-alist))
        (unless (equal (cdr item) 0)
          (setq donesomething t)
          (setq h (/ (cdr item) 60)
                m (- (cdr item) (* 60 h)))
          (setq output-string (concat output-string (format "[-%s-] %.2d:%.2d\n" (car item) h m)))))
      (unless donesomething
        (setq output-string (concat output-string "[-Nothing-] Done nothing!!!\n")))
      (unless noinsert
        (insert output-string))
      output-string))

(add-to-load-path "~/.spacemacs.d/package/org-protocol-capture-html")
(server-start)
(require 'org-protocol)
(require 'org-protocol-capture-html)

(define-key global-map (kbd "<f9>") 'org-capture)

(setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Daily Tasks")
           "* TODO %?\n%i%U"
           :empty-lines 1)
          ("w" "Web site" entry (file "~/Emacs-lengyue/Wiki-lengyue/Bookmark.org")
           "* %c :website:\n%?\n%U %:initial"
          :empty-lines 1)
          ("i" "Inbox" entry (file+headline org-agenda-file-gtd "Inbox")
           "* INBOX %?\n%i%U"
           :empty-lines 1)
          ("e" "Quick Notes" entry (file+headline org-agenda-file-gtd "Quick Notes")
           "* NOTE %?\n%i%U"
           :empty-lines 1)
          ("b" "Blog Ideas" entry (file+headline org-agenda-file-gtd "Blog Ideas")
           "* TODO %?\n%i%U"
           :empty-lines 1)
          ("m" "Someday/Maybe" entry (file+headline org-agenda-file-gtd "Someday/Maybe")
           "* SOMEDAY %?\n%i%U"
           :empty-lines 1)))

(setq org-confirm-babel-evaluate nil)

(setq org-plantuml-jar-path
      (expand-file-name "/opt/plantuml/plantuml.jar"))
;; (setq org-ditta-jar-path
;;  (expand-file-name "/usr/share/java/ditaa/ditaa-0_9.jar"))


(eval-after-load 'org
  '(progn
     (defun lengyueyang/org-insert-src-block (src-code-type)
       "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
       (interactive
        (let ((src-code-types
               '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
                 "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
                 "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
                 "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
                 "scheme" "sqlite" "ipython")))
          (list (ido-completing-read "Source code type: " src-code-types))))
       (progn
         (newline-and-indent)
         (insert (format "#+BEGIN_SRC %s\n" src-code-type))
         (newline-and-indent)
         (insert "#+END_SRC\n")
         (previous-line 2)
         (org-edit-src-code)))

     (add-hook 'org-mode-hook '(lambda ()
                                 ;; keybinding for editing source code blocks
                                 ;; keybinding for inserting code blocks
                                 (local-set-key (kbd "C-c i s")
                                                'lengyueyang/org-insert-src-block)
                                 ))

     (org-babel-do-load-languages
      'org-babel-load-languages
      '((perl . t)
        (ruby . t)
        (sh . t)
        (js . t)
        (python . t)
        (ipython . t)
        (emacs-lisp . t)
        (plantuml . t)
        (R . t)
        (dot . t)
        (gnuplot . t)
        (latex . t)
        (C . t)
        (ditaa . t)))
     )
  )


;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)

(require 'ob-ipython)
;; (setq org-babel-python-command "/usr/bin/ipython --pylab --pdb --nosep")
(setq python-shell-prompt-detect-failure-warning nil)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;;org-mode export to latex
(require 'ox-latex)
(setq org-export-latex-listings t)

;;org-mode source code setup in exporting to latex
(add-to-list 'org-latex-listings
             '("" "listings"))
(add-to-list 'org-latex-listings
             '("" "color"))

(add-to-list 'org-latex-packages-alist
             '("" "xcolor" t))
(add-to-list 'org-latex-packages-alist
             '("" "listings" t))
(add-to-list 'org-latex-packages-alist
             '("" "fontspec" t))
(add-to-list 'org-latex-packages-alist
             '("" "indentfirst" t))
(add-to-list 'org-latex-packages-alist
             '("" "xunicode" t))
(add-to-list 'org-latex-packages-alist
             '("" "geometry"))
(add-to-list 'org-latex-packages-alist
             '("" "float"))
(add-to-list 'org-latex-packages-alist
             '("" "longtable"))
(add-to-list 'org-latex-packages-alist
             '("" "tikz"))
(add-to-list 'org-latex-packages-alist
             '("" "fancyhdr"))
(add-to-list 'org-latex-packages-alist
             '("" "textcomp"))
(add-to-list 'org-latex-packages-alist
             '("" "amsmath"))
(add-to-list 'org-latex-packages-alist
             '("" "tabularx" t))
(add-to-list 'org-latex-packages-alist
             '("" "booktabs" t))
(add-to-list 'org-latex-packages-alist
             '("" "grffile" t))
(add-to-list 'org-latex-packages-alist
             '("" "wrapfig" t))
(add-to-list 'org-latex-packages-alist
             '("normalem" "ulem" t))
(add-to-list 'org-latex-packages-alist
             '("" "amssymb" t))
(add-to-list 'org-latex-packages-alist
             '("" "capt-of" t))
(add-to-list 'org-latex-packages-alist
             '("figuresright" "rotating" t))
(add-to-list 'org-latex-packages-alist
             '("Lenny" "fncychap" t))

(add-to-list 'org-latex-classes
             '("lengyue-org-book"
               "\\documentclass{book}
\\usepackage[slantfont, boldfont]{xeCJK}
% chapter set
\\usepackage{titlesec}
\\usepackage{hyperref}

[NO-DEFAULT-PACKAGES]
[PACKAGES]


\\setCJKmainfont{WenQuanYi Micro Hei} % 设置缺省中文字体
\\setCJKsansfont{WenQuanYi Micro Hei}
\\setCJKmonofont{WenQuanYi Micro Hei Mono}

\\setmainfont{DejaVu Sans} % 英文衬线字体
\\setsansfont{DejaVu Serif} % 英文无衬线字体
\\setmonofont{DejaVu Sans Mono}
%\\setmainfont{WenQuanYi Micro Hei} % 设置缺省中文字体
%\\setsansfont{WenQuanYi Micro Hei}
%\\setmonofont{WenQuanYi Micro Hei Mono}

%如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。
\\defaultfontfeatures{Mapping=tex-text}

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left,
numberstyle= \\tiny,
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},
frame=shadowbox,
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20}
}

[EXTRA]
"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("lengyue-org-article"
               "\\documentclass{article}
\\usepackage[slantfont, boldfont]{xeCJK}
\\usepackage{titlesec}
\\usepackage{hyperref}

[NO-DEFAULT-PACKAGES]
[PACKAGES]

\\parindent 2em

\\setCJKmainfont{WenQuanYi Micro Hei} % 设置缺省中文字体
\\setCJKsansfont{WenQuanYi Micro Hei}
\\setCJKmonofont{WenQuanYi Micro Hei Mono}

\\setmainfont{DejaVu Sans} % 英文衬线字体
\\setsansfont{DejaVu Serif} % 英文无衬线字体
\\setmonofont{DejaVu Sans Mono}
%\\setmainfont{WenQuanYi Micro Hei} % 设置缺省中文字体
%\\setsansfont{WenQuanYi Micro Hei}
%\\setmonofont{WenQuanYi Micro Hei Mono}

%如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。
\\defaultfontfeatures{Mapping=tex-text}

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left,
numberstyle= \\tiny,
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},
frame=shadowbox,
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20}
}

[EXTRA]
"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("lengyue-org-beamer"
               "\\documentclass{beamer}
\\usepackage[slantfont, boldfont]{xeCJK}
% beamer set
\\usepackage[none]{hyphenat}
\\usepackage[abs]{overpic}

[NO-DEFAULT-PACKAGES]
[PACKAGES]

\\setCJKmainfont{WenQuanYi Micro Hei} % 设置缺省中文字体
\\setCJKsansfont{WenQuanYi Micro Hei}
\\setCJKmonofont{WenQuanYi Micro Hei Mono}

\\setmainfont{DejaVu Sans} % 英文衬线字体
\\setsansfont{DejaVu Serif} % 英文无衬线字体
\\setmonofont{DejaVu Sans Mono}
%\\setmainfont{WenQuanYi Micro Hei} % 设置缺省中文字体
%\\setsansfont{WenQuanYi Micro Hei}
%\\setmonofont{WenQuanYi Micro Hei Mono}

%如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。
\\defaultfontfeatures{Mapping=tex-text}

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left,
numberstyle= \\tiny,
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},
frame=shadowbox,
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20}
}

[EXTRA]
"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          ;;"biber %b" "xelatex -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"))

(setq org-link-abbrev-alist
      '(("google" . "http://www.google.com/search?q=")
        ("google-map" . "http://maps.google.com/maps?q=%s")
        ))

(add-to-load-path "~/.spacemacs.d/package/org-subtask-reset")
(require 'org-subtask-reset)

(add-to-load-path "~/.spacemacs.d/package/org-checklist")
(require 'org-checklist)

;; It's wrong to load org-archive-subtree-hierarchical, so add here
(load "~/.spacemacs.d/package/org-archive-subtree-hierarchical/org-archive-subtree-hierarchical.el")

(setq org-ref-default-bibliography '("~/Emacs-lengyue/Papers/references.bib")
      org-ref-pdf-directory "~/Emacs-lengyue/Papers/"
      org-ref-bibliography-notes "~/Emacs-lengyue/Papers/notes.org")

(add-hook 'R-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'R-mode-hook 'smartparens-mode)
(add-hook 'R-mode-hook 'flycheck-mode)
(add-hook 'R-mode-hook 'flyspell-mode)
(add-hook 'inferior-ess-mode-hook 'company-mode)
(add-hook 'inferior-ess-mode-hook 'smartparens-mode)
(add-hook 'inferior-ess-mode-hook 'flycheck-mode)
(add-hook 'inferior-ess-mode-hook 'flyspell-mode)

(add-hook 'python-mode-hook (lambda () (setq truncate-lines nil)))
(setq python-fill-column 80)
(add-hook 'inferior-python-mode-hook 'flycheck-mode)
(add-hook 'inferior-python-mode-hook 'flyspell-mode)

(req-package pangu-spacing
  :init
  (progn
    ;; start pangu-spacing globally
    (global-pangu-spacing-mode 1)
    ;; Always insert `real' space in org-mode.
    (add-hook 'org-mode-hook
              '(lambda ()
                 (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))))

;; (add-to-load-path "~/.spacemacs.d/package/blog-admin")

(require 'blog-admin)

;;  (setq blog-admin-backend-type 'org-page)
;;  (setq blog-admin-backend-path "~/Emacs-lengyue/Blog-lengyue/source")
;;  (setq blog-admin-backend-new-post-in-drafts t)
;;  (setq blog-admin-backend-new-post-with-same-name-dir t)
;;  (setq blog-admin-backend-org-page-drafts "_drafts")

;;  (setq op/repository-directory "~/Emacs-lengyue/Blog-lengyue/source")
;;  (setq op/site-domain "http://lengyueyang.github.io") 
;;  (setq op/personal-disqus-shortname "lengyueyang")

(setq blog-admin-backend-type 'hexo)
(setq blog-admin-backend-path "~/Emacs-lengyue/Blog-lengyue/")
(setq blog-admin-backend-new-post-in-drafts t)
(setq blog-admin-backend-new-post-with-same-name-dir t)

(require'cl)

(setq hexo-dir "~/Emacs-lengyue/Blog-lengyue")

(defun lengyueyang/hexo-publish (commit-msg)
  "git add . & git commit & git push & hexo d"
  (interactive "sInput commit message:")
  (async-shell-command (format "cd %s ;git add . ;git commit -m \"%s\" ;git push ;hexo clean; hexo g; hexo d -g"
                               hexo-dir
                               commit-msg)))

(defun lengyueyang/hexo-org-add-read-more ()
  "add <!--more-->"
  (interactive)
  (insert "#+BEGIN_HTML\n<!--more-->\n#+END_HTML"))

(defun lengyueyang/hexo-org-new-open-post (post-name)
  "create a hexo org post"
  (interactive "sInput post name:")
  (find-file (format "%s/source/_posts/%s.org" hexo-dir post-name))
  (insert (format "#+TITLE: %s
#+DATE: %s
#+LAYOUT: post
#+TAGS:
#+CATEGORIES:
"  post-name (format-time-string "<%Y-%m-%d %a %H:%M>"))))

(defun lengyueyang/hexo-org-source ()
  "use dired open hexo source dir"
  (interactive)
  (ido-find-file-in-dir (format "%s/source/" hexo-dir))
  )

(defun lengyueyang/hexo-move-article ()
  "Move current file between _post and _draft;
You can run this function in dired or a hexo article."
  (interactive)
  (if (string-match "/\\(_posts/\\|_drafts/\\)$" default-directory)
      (let* ((parent-dir (file-truename (concat default-directory "../")))
             (dest-dir (if (string-match "_drafts/$" default-directory) "_posts/" "_drafts/"))))
        (cond (or (eq major-mode 'markdown-mode) (eq major-mode 'org-mode))
               (let* ((cur-file (buffer-file-name))
                      (new-file (concat parent-dir dest-dir (buffer-name))))
                 (save-buffer)
                 (kill-buffer)
                 (rename-file cur-file new-file)
                 (find-file new-file)
                 (message (format "Now in %s" dest-dir))))
              ((eq major-mode 'dired-mode)
               (dired-rename-file (dired-get-filename nil)
                                  (concat parent-dir dest-dir (dired-get-filename t))
                                  nil)
               (message (format "The article has been moved to %s" dest-dir))))
    (message "You have to run this in a hexo article buffer or dired"))

(add-hook 'spacemacs-buffer-mode-hook (lambda ()
(set (make-local-variable 'mouse-1-click-follows-link) nil)))

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'R-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'python-mode-hook (lambda () (setq truncate-lines nil)))

(defun lengyueyang/hotspots ()
  "helm interface to my hotspots, which includes my locations,
org-files and bookmarks"
  (interactive)
  (helm :buffer "*helm: utities*"
        :sources `(,(lengyueyang//hotspots-sources))))

(defun lengyueyang//hotspots-sources ()
  "Construct the helm sources for my hotspots"
  `((name . "lengyueyang's center")
    (candidates . (
                   ("Agenda" . (lambda () (org-agenda "" "a")))
                   ("Blog" . (lambda() (blog-admin-start)))
                   ("Elfeed" . (lambda () (elfeed)))
                   ("Agenda Next TODO" . (lambda () (org-agenda "" "t")))
                   ("Agenda Menu" . (lambda () (org-agenda)))
                   ("Open Github" . (lambda() (browse-url "https://github.com/lengyueyang")))
                   ("Open Blog" . (lambda() (browse-url "http://lengyueyang.github.io")))))
    (candidate-number-limit)
    (action . (("Open" . (lambda (x) (funcall x)))))))

(define-key global-map (kbd "<f1>") 'lengyueyang/hotspots)

(defun lengyueyang/word-count-for-chinese ()
  "「較精確地」統計中 / 日 / 英文字數。
- 文章中的註解不算在字數內。
- 平假名與片假名亦包含在「中日文字數」內，每個平 / 片假名都算單獨一個字（但片假
  名不含連音「ー」）。
- 英文只計算「單字數」，不含標點。
- 韓文不包含在內。
※計算標準太多種了，例如英文標點是否算入、以及可能有不太常用的標點符號沒算入等
。且中日文標點的計算標準要看 Emacs 如何定義特殊標點符號如ヴァランタン・アルカン
中間的點也被 Emacs 算為一個字而不是標點符號。"
  (interactive)
  (let* ((v-buffer-string
          (progn
            (if (eq major-mode 'org-mode) ; 去掉 org 文件的 OPTIONS（以 #+ 開頭）
                (setq v-buffer-string (replace-regexp-in-string "^#\\+.+" ""
                                                                (buffer-substring-no-properties (point-min) (point-max))))
              (setq v-buffer-string (buffer-substring-no-properties (point-min) (point-max))))
            (replace-regexp-in-string (format "^ *%s *.+" comment-start) "" v-buffer-string)))
                                        ; 把註解行刪掉（不把註解算進字數）。
         (chinese-char-and-punc 0)
         (chinese-punc 0)
         (english-word 0)
         (chinese-char 0))
    (with-temp-buffer
      (insert v-buffer-string)
      (goto-char (point-min))
      ;; 中文（含標點、片假名）
      (while (re-search-forward wc-regexp-chinese-char-and-punc nil :no-error)
        (setq chinese-char-and-punc (1+ chinese-char-and-punc)))
      ;; 中文標點符號
      (goto-char (point-min))
      (while (re-search-forward wc-regexp-chinese-punc nil :no-error)
        (setq chinese-punc (1+ chinese-punc)))
      ;; 英文字數（不含標點）
      (goto-char (point-min))
      (while (re-search-forward wc-regexp-english-word nil :no-error)
        (setq english-word (1+ english-word))))
    (setq chinese-char (- chinese-char-and-punc chinese-punc))
    (message
     (format " 中日文字數（不含標點）：%s
 中日文字數（包含標點）：%s
 英文字數（不含標點）：%s
=======================
 中英文合計（不含標點）：%s"
             chinese-char chinese-char-and-punc english-word
             (+ chinese-char english-word)))))

(req-package-finish)
