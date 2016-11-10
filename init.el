;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      ;;                 auto-completion-return-key-behavior 'complete
                      ;;                 auto-completion-tab-key-behavior 'cycle
                      ;;                 auto-completion-complete-with-key-sequence nil
                      ;;                 auto-completion-complete-with-key-sequence-delay 0
                      ;;                 auto-completion-private-snippets-directory nil
                      auto-completion-enable-snippets-in-popup t
                      ;;                 auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      :disabled-for org markdown)
     better-defaults
     (chinese :packages youdao-dictionary
              :variables chinese-enable-youdao-dict t)
     emacs-lisp
     (git :variables
          git-magit-status-fullscreen t
          magit-push-always-verify nil
          magit-save-repository-buffers 'dontask
          magit-revert-buffers 'silent
          magit-refs-show-commit-count 'all
          magit-revision-show-gravatars nil)
     github
     javascript
     (typescript :variables
                 typescript-fmt-on-save nil
                 typescript-fmt-tool 'typescript-formatter)
     bibtex
     ;; helm
     ivy
     yaml
     (latex :variables latex-enable-auto-fill t)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode)
     (ess :variables ess-enable-smart-equals t)
     racket
     (python :variables
             python-test-runner '(nose pytest)
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
                     spell-checking-enable-by-default t)
     version-control
     (colors :variables
             colors-enable-nyan-cat-progress-bar t)

     pandoc
     semantic
     graphviz
     (ranger :variables ranger-show-preview t)
     pdf-tools
     prodigy
     search-engine
     (vinegar :variables vinegar-reuse-dired-buffer t)
     (spacemacs-layouts :variables layouts-enable-autosave nil
                        layouts-autosave-delay 300)
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     restclient
     (gtags :disabled-for clojure emacs-lisp javascript latex python shell-scripts ess)
     docker
     deft
     shaders
     react
     (ruby :variables ruby-version-manager 'chruby)
     ruby-on-rails
     lua
     html
     (clojure :variables clojure-enable-fancify-symbols t)
     (elfeed :variables
             ;;elfeed-enable-web-interface t
             rmh-elfeed-org-files (list "~/Emacs-lengyue/Wiki-lengyue/Elfeed.org"))

     )
   dotspacemacs-additional-packages '(nodejs-repl
                                      youdao-dictionary
                                      chinese-yasdcv
                                      req-package
                                      blog-admin
                                      ob-ipython
                                      auctex-latexmk)
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("WenQuanYi Micro Hei Mono"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-command-key "SPC"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-display-default-layout nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   ))

(defun dotspacemacs/user-init ()
  (setq configuration-layer--elpa-archives
        '(("melpa-cn" . "http://elpa.zilongshanren.com/melpa/")
          ("org-cn"   . "http://elpa.zilongshanren.com/org/")
          ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")))
  )

(defun dotspacemacs/user-config ()
  (require 'ob-tangle)
  (org-babel-load-file
    (expand-file-name "lengyueyang.org"
                      dotspacemacs-directory))
  )

(setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
(load custom-file 'no-error 'no-message)
