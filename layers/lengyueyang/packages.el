;;; packages.el --- lengyueyang Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq lengyueyang-packages
      '(
        ;; package names go here
        fcitx
        ;; realgud
        org-bullets
        org
        org-plus-contrib
        uimage
        hl-sexp
        aggressive-indent
        sws-mode
        org-caldav
        (plain-org-wiki :location local)
        ))

;; List of packages to exclude.
(setq lengyueyang-excluded-packages '())

;; For each package, define a function lengyueyang/init-<package-name>
;;


(defun lengyueyang/init-fcitx  ()
  (use-package fcitx
    :defer t
    :init
    (fcitx-aggressive-setup)
    ))

(defun lengyueyang/init-org-caldav ()
  (use-package org-caldav
    ))



(defun lengyueyang/init-uimage ()
  (use-package uimage
    :defer t
    ))

(defun lengyueyang/init-realgud ()
  (use-package realgud
    :defer t
    :init (load-library "realgud")
    ))

(defun lengyueyang/init-erc-colorize ()
  (use-package colorize
    :defer t
    :init (add-hook 'erc-mode-hook 'erc-colorize-mode)
    ))
(defun lengyueyang/init-hl-sexp ()
  (use-package hl-sexp
    :defer t
    :init
    (progn
      (add-hook 'lisp-mode-hook 'hl-sexp-mode)
      (add-hook 'emacs-lisp-mode-hook 'hl-sexp-mode)
      )))

(defun lengyueyang/post-init-aggressive-indent ()
  (progn
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
    (add-hook 'css-mode-hook #'aggressive-indent-mode)
    ))

(defun lengyueyang/post-init-org-bullets ()
  (setq org-bullets-bullet-list '("☰" "☷" "⋗" "⇀")))

(defun lengyueyang/post-init-org ()
  (setq org-agenda-dir "~/Emacs-lengyue/GTD-lengyue")
  (setq org-agenda-file-gtd (expand-file-name "GTD-lengyue.org" org-agenda-dir))
  (setq org-agenda-file-gtd-archive (expand-file-name "GTD-lengyue.org_archive" org-agenda-dir))
  (setq org-agenda-files `(,org-agenda-file-gtd ,org-agenda-file-gtd-archive))

  (setq org-default-notes-file org-agenda-file-gtd)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|"  "DONE(d)")
          (sequence "WAITING(w@/!)" "SOMEDAY(s)" "|" "HOLD(h@/!)" "CANCELLED(c@/!)")
          (sequence "INBOX(i)" "|" "NOTE(e)" "PHONE(p)" "MEETING(m)")
          (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))

  (setq org-refile-targets
        '(("GTD-lengyue.org" :maxlevel . 1)))

  (setq org-log-into-drawer t)

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Daily Tasks")
           "* TODO %?\n%i%U" 
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
           ((stuck "")            ;; review stuck projects as designated by org-stuck-projects
            (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
            ))))

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)  ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook'org-after-todo-statistics-hook 'org-summary-todo)
  
  ;; used by org-clock-sum-today-by-tags
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

  (eval-after-load 'org
    '(progn
       (global-set-key (kbd "C-c a") 'org-agenda)
       (define-key org-mode-map (kbd "s-p") 'org-priority)
       (define-key global-map (kbd "<f9>") 'org-capture)
       (global-set-key (kbd "C-c b") 'org-iswitchb)
       (define-key evil-normal-state-map (kbd "C-c C-w") 'org-refile)
       (evil-leader/set-key-for-mode'org-mode
        "owh" 'plain-org-wiki-helm
        "owf" 'plain-org-wiki)
       (require 'ob-js)
       (require 'ob-shell)

       (defun lengyueyang/org-insert-src-block (src-code-type)
         "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
         (interactive
          (let ((src-code-types
                 '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
                   "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
                   "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
                   "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
                   "scheme" "sqlite")))
            (list (ido-completing-read "Source code type: " src-code-types))))
         (progn
           (newline-and-indent)
           (insert (format "#+BEGIN_SRC %s\n" src-code-type))
           (newline-and-indent)
           (insert "#+END_SRC\n")
           (previous-line 2)
           (org-edit-src-code)))

       (org-babel-do-load-languages
        'org-babel-load-languages
        '((perl . t)
          (ruby . t)
          (sh . t)
          (js . t)
          (python . t)
          (emacs-lisp . t)
          (plantuml . t)
          (R . t)
          (dot . t)
          (gnuplot . t)
          (latex . t)
          (C . t)
          (ditaa . t)))

       (add-hook 'org-mode-hook '(lambda ()
                                   ;; keybinding for editing source code blocks
                                   ;; keybinding for inserting code blocks
                                   (local-set-key (kbd "C-c i s")
                                                  'lengyueyang/org-insert-src-block)
                                   ))


       )
    )


  ;; Resume clocking task when emacs is restarted
  (org-clock-persistence-insinuate)
  ;; Save the running clock and all clock history when exiting Emacs, load it on startup
  (setq org-clock-persist t)
  ;; Do not prompt to resume an active clock
  (setq org-clock-persist-query-resume nil)

  ;; Sync with google calander
  (setq org-caldav-url "https://www.google.com/calendar/dav")
  (setq org-caldav-calendar-id "maoxiaoweihl@gmail.com")
  (setq org-caldav-files org-agenda-files)
  (setq org-icalendar-date-time-format ";TZID=%Z:%Y%m%dT%H%M%S")

  )

