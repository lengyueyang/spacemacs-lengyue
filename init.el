;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                       auto-completion-return-key-behavior 'complete
                       auto-completion-tab-key-behavior 'cycle
                       auto-completion-complete-with-key-sequence nil
                       auto-completion-complete-with-key-sequence-delay 0
                       auto-completion-private-snippets-directory nil
                       auto-completion-enable-snippets-in-popup t
                       auto-completion-enable-help-tooltip t
                       auto-completion-enable-sort-by-usage t)
     better-defaults
     chinese
     emacs-lisp
     git
     github
     (latex :variables latex-enable-auto-fill t)
     c-c++
     (ess :variables ess-enable-smart-equals t)
     racket
     (python :variables 
              python-test-runner 'node
              python-enable-yapf-format-on-save t)
     ipython-notebook
     markdown
     org
     (shell :variables 
         shell-default-shell 'eshell)
     (syntax-checking :variables
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t)    
     (spell-checking :variables 
                      ;;"spell-checking-enable-auto-dictionary t"
                      spell-checking-enable-by-default t)
     version-control
     (colors :variables
             colors-enable-nyan-cat-progress-bar t)
     lengyueyang
     pandoc
     ;;chinese
     ;;zilongshanren
     (elfeed :variables 
              ;;elfeed-enable-web-interface t                
              rmh-elfeed-org-files (list "~/Emacs-lengyue/Wiki-lengyue/Elfeed.org"))
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("WenQuanYi Micro Hei Mono"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ))

(defun dotspacemacs/user-init ()
  (setq python-fill-column 99)
  (add-hook 'R-mode-hook 'smartparens-mode)
  (add-hook 'R-mode-hook 'flycheck-mode)
  (add-hook 'R-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'smartparens-mode)
  (add-hook 'org-mode-hook (lambda () (org-indent-mode t)) t)
  (add-hook 'inferior-ess-mode-hook 'company-mode)
  (add-hook 'inferior-ess-mode-hook 'smartparens-mode)
  (add-hook 'inferior-ess-mode-hook 'flycheck-mode)
  (add-hook 'inferior-ess-mode-hook 'flyspell-mode)


  (add-hook 'inferior-python-mode-hook 'flycheck-mode)
  (add-hook 'inferior-python-mode-hook 'flyspell-mode)

  (setq-default dotspacemacs-line-numbers t)
  (setq-default dotspacemacs-smartparens-strict-mode t)


  "Initialization function for user code.It is called immediately after `dotspacemacs/init'.  You are free to put any user code."
  )

(defun dotspacemacs/user-config ()

  (spacemacs//set-monospaced-font   "WenQuanYi Micro Hei Mono" "WenQuanYi Micro Hei Mono" 16 20)

  (setq org-columns-default-format "%50ITEM(Task) %CATEGORY %SCHEDULED %5Effort %5CLOCKSUM %PRIORITY")

  (setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))

  (setq org-latex-pdf-process
     '("xelatex -interaction nonstopmode -output-directory %o %f" 
       "biber %b" "xelatex -interaction nonstopmode -output-directory %o %f" 
       "xelatex -interaction nonstopmode -output-directory %o %f"
       "xelatex -interaction nonstopmode -output-directory %o %f"))

(setq org-agenda-files (list "~/Emacs-lengyue/GTD-lengyue"))

(require 'org-notify)
(org-notify-start)
(org-notify-add 'appt
                 '(:time "-1s" :period "20s" :duration 10
                   :actions (-message -ding))
                 '(:time "15m" :period "2m" :duration 100
                   :actions -notify)
                 '(:time "2h" :period "5m" :actions -message)
                 '(:time "3d" :actions -email))


(require 'org-archive)

(defun org-archive-subtree-hierarchical--line-content-as-string ()
  "Returns the content of the current line as a string"
  (save-excursion
    (beginning-of-line)
    (buffer-substring-no-properties
     (line-beginning-position) (line-end-position))))

(defun org-archive-subtree-hierarchical--org-child-list ()
  "This function returns all children of a heading as a list. "
  (interactive)
  (save-excursion
    ;; this only works with org-version > 8.0, since in previous
    ;; org-mode versions the function (org-outline-level) returns
    ;; gargabe when the point is not on a heading.
    (if (= (org-outline-level) 0)
        (outline-next-visible-heading 1)
      (org-goto-first-child))
    (let ((child-list (list (org-archive-subtree-hierarchical--line-content-as-string))))
      (while (org-goto-sibling)
        (setq child-list (cons (org-archive-subtree-hierarchical--line-content-as-string) child-list)))
      child-list)))

(defun org-archive-subtree-hierarchical--org-struct-subtree ()
  "This function returns the tree structure in which a subtree
belongs as a list."
  (interactive)
  (let ((archive-tree nil))
    (save-excursion
      (while (org-up-heading-safe)
        (let ((heading
               (buffer-substring-no-properties
                (line-beginning-position) (line-end-position))))
          (if (eq archive-tree nil)
              (setq archive-tree (list heading))
            (setq archive-tree (cons heading archive-tree))))))
    archive-tree))

(defun org-archive-subtree-hierarchical ()
  "This function archives a subtree hierarchical"
  (interactive)
  (let ((org-tree (org-archive-subtree-hierarchical--org-struct-subtree))
        (this-buffer (current-buffer))
        (file (abbreviate-file-name
               (or (buffer-file-name (buffer-base-buffer))
                   (error "No file associated to buffer")))))
    (save-excursion
      (setq location (org-get-local-archive-location)
            afile (org-extract-archive-file location)
            heading (org-extract-archive-heading location)
            infile-p (equal file (abbreviate-file-name (or afile ""))))
      (unless afile
        (error "Invalid `org-archive-location'"))
      (if (> (length afile) 0)
          (setq newfile-p (not (file-exists-p afile))
                visiting (find-buffer-visiting afile)
                buffer (or visiting (find-file-noselect afile)))
        (setq buffer (current-buffer)))
      (unless buffer
        (error "Cannot access file \"%s\"" afile))
      (org-cut-subtree)
      (set-buffer buffer)
      (org-mode)
      (goto-char (point-min))
      (while (not (equal org-tree nil))
        (let ((child-list (org-archive-subtree-hierarchical--org-child-list)))
          (if (member (car org-tree) child-list)
              (progn
                (search-forward (car org-tree) nil t)
                (setq org-tree (cdr org-tree)))
            (progn
              (goto-char (point-max))
              (newline)
              (org-insert-struct org-tree)
              (setq org-tree nil)))))
      (newline)
      (org-yank)
      (when (not (eq this-buffer buffer))
        (save-buffer))
      (message "Subtree archived %s"
               (concat "in file: " (abbreviate-file-name afile))))))

(defun org-insert-struct (struct)
  "TODO"
  (interactive)
  (when struct
    (insert (car struct))
    (newline)
    (org-insert-struct (cdr struct))))

(defun org-archive-subtree ()
  (org-archive-subtree-hierarchical)
  )

(add-hook 'org-pomodoro-finished-hook
           (lambda ()
             (codefalling//notify "Pomodoro completed!" "Time for a break.")))
(add-hook 'org-pomodoro-break-finished-hook
           (lambda ()
             (codefalling//notify "Pomodoro Short Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-long-break-finished-hook
           (lambda ()
             (codefalling//notify "Pomodoro Long Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-killed-hook
           (lambda ()
             (codefalling//notify "Pomodoro Killed" "One does not simply kill a pomodoro!")))

(setq org-default-properties (cons "RESET_SUBTASKS" org-default-properties))

(defun org-reset-subtask-state-subtree ()
  "Reset all subtasks in an entry subtree."
  (interactive "*")
  (if (org-before-first-heading-p)
      (error "Not inside a tree")
    (save-excursion
      (save-restriction
    (org-narrow-to-subtree)
    (org-show-subtree)
    (goto-char (point-min))
        (beginning-of-line 2)
        (narrow-to-region (point) (point-max))
        (org-map-entries
         '(when (member (org-get-todo-state) org-done-keywords)
            (org-todo (car org-todo-keywords))))
        ))))

(defun org-reset-subtask-state-maybe ()
  "Reset all subtasks in an entry if the `RESET_SUBTASKS' property is set"
  (interactive "*")
  (if (org-entry-get (point) "RESET_SUBTASKS")
      (org-reset-subtask-state-subtree)))

(defun org-subtask-reset ()
  (when (member org-state org-done-keywords) ;; org-state dynamically bound in org.el/org-todo
    (org-reset-subtask-state-maybe)
    (org-update-statistics-cookies t)))

(add-hook 'org-after-todo-state-change-hook 'org-subtask-reset)

;;  (global-linum-mode t)
;;  (add-to-load-path "~/.spacemacs.d/package/ox-pandoc")
;;  (require 'ox-pandoc)
;;  (setq org-pandoc-options '((standalone . t)))
;; cancel above settings only for 'docx' format
;;  (setq org-pandoc-options-for-docx '((standalone . nil)))
;; special settings for beamer-pdf and latex-pdf exporters
;;  (setq org-pandoc-options-for-beamer-pdf '((latex-engine . "xelatex")))
;;  (setq org-pandoc-options-for-latex-pdf '((latex-engine . "xelatex")))
;;  (setq org-latex-texport-to-pdf '("xelatex %f && biber %f && xelatex %f && xelatex %f"))
;;  (setq org-beamer-export-to-pdf (list "latexmk -pdf -biber %f"))


;;  (with-eval-after-load 'org-agenda
;;    (define-key org-agenda-mode-map (kbd "RET") 'org-agenda-goto))

  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil))) 
  (add-hook 'R-mode-hook (lambda () (setq truncate-lines nil))) 
  (add-hook 'python-mode-hook (lambda () (setq truncate-lines nil))) 

;;  (add-to-load-path "~/.spacemacs.d/package/popup")
;;  (require 'popup)

;;  (add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20151227.354/")
;;  (when (require 'auto-complete-config))
;;  (ac-config-default)

;;  (setq ess-use-auto-complete t)
  (setq ess-ask-for-ess-directory nil)

;;  (setq ac-use-menu-map t)
;;    (define-key ac-menu-map (kbd "C-n") 'ac-next)
;;    (define-key ac-menu-map (kbd "C-p") 'ac-previous)
;;  (define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
;; unbind some keys (inconvenient in iESS buffers)
;;    (define-key ac-completing-map (kbd "M-n") nil)
;;    (define-key ac-completing-map (kbd "M-p") nil)

;;  (setq ac-sources
;;    (append '(ac-source-features
;;      ac-source-functions
;;      ac-source-yasnippet
;;      ac-source-variables
;;      ac-source-symbols)
;;      ac-sources))

;;  (setq ac-delay 0)       
;;  (setq ac-auto-show-menu 0.1)
;;  (setq ac-quick-help-delay 0.1)
;;  (setq ac-quick-help-height 10)
;;  (setq ac-candidate-limit 100)
;;    (set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
;;    (set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "light gray")
;;    (set-face-attribute 'popup-tip-face    nil   :background "SteelBlue4" :foreground "light gray")
;; completion by TAB
;;    (define-key ac-completing-map
;;    (kbd "<tab>") 'ac-complete)

;; ESS: Emacs Speaks Statistics
;;    (add-to-list 'load-path "~/.emacs.d/elpa/ess-20140824.1452/lisp/")

;;  (setq shell-file-name "zsh.exe")

;;(add-to-list 'auto-mode-alist '("\\.[rR]\\'" . R-mode))

;;(autoload 'R "ess-site" "Call 'R', the 'GNU S' system from the R Foundation." t)
;;(autoload 'R-mode "ess-site" "Major mode for editing R source." t)

;;  (setq ess-ask-for-ess-directory nil)
;;  (setq inferior-ess-same-window nil)
;;  (setq ess-default-style 'DEFAULT)

;;  (with-eval-after-load "ess-site"

;;  use eldoc to report R function names
;;  (require 'ess-eldoc)
;;  (add-hook 'inferior-ess-mode-hook 'ess-use-eldoc))


  (add-to-load-path "~/.spacemacs.d/package/blog-admin")
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

;;  (add-to-list 'after-make-frame-functions (lambda () (toggle-frame-maximized)))


"Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(magit-log-section-arguments (quote ("--decorate" "-n256")))
 '(org-agenda-files
   (quote
    ("/home/lengyue/Emacs-lengyue/GTD-lengyue/GTD-lengyue.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

