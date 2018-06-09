;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation nil
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     ;; ---chat---
     (slack :variables slack-spacemacs-layout-name "@Slack"
            slack-spacemacs-layout-binding "s")
     jabber
     (erc :variables  erc-spacemacs-layout-name "@ERC"
          erc-spacemacs-layout-binding "e")
     ;; ---checkers---
     (spell-checking :variables
                     spell-checking-enable-by-default t)
     (syntax-checking :variables
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t)
     ;; ---completion---
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-private-snippets-directory t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      :disabled-for org markdown)
     (ivy :variables ivy-enable-advanced-buffer-information t)
     ;; templates
     ;; helm
     ;; ---emacs---
     (better-defaults :variables
                      better-defaults-move-to-beginning-of-code-first t
                      better-defaults-move-to-end-of-code-first nil)
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     (org :variables
          org-enable-github-support t
          org-enable-bootstrap-support t
          org-enable-reveal-js t
          ;; org-enable-org-journal-support t
          ;; org-projectile-file "TODOs.org"
          org-want-todo-bindings t)
     semantic
     (typography :variables typography-enable-typographic-editing t)
     ;; ---email---
     (mu4e :variables
           mu4e-installation-path "/usr/share/emacs/site-lisp/mu"
           mu4e-use-maildirs-extension t
           mu4e-enable-async-operations t
           mu4e-enable-mode-line t
           mu4e-spacemacs-layout-name "@Mu4e"
           mu4e-spacemacs-layout-binding "m")
     gnus
     ;; ---filetree---
     (treemacs :variables treemacs-use-follow-mode t
               treemacs-use-filewatch-mode t
               treemacs-use-collapsed-directories 3)
     ;; ---fonts---
     unicode-fonts
     ;; ---frameworks---
     ruby-on-rails
     django
     ;; ---fun---
     emoji
     ;; ---intl---
     (chinese :packages youdao-dictionary
              :variables chinese-enable-youdao-dict t)
     ;; ---lang---
     bibtex
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t
            c-c++-enable-clang-format-on-save t
            c-c++-enable-rtags-support t
            c-c++-enable-google-style t
            c-c++-enable-auto-newline t)
     emacs-lisp
     (ess :variables ess-disable-underscore-assign t)
     graphviz
     hy
     ipython-notebook
     (javascript :variables javascript-backend 'tern)
     json
     (latex :variables latex-enable-auto-fill t)
     lua
     (markdown :variables markdown-mmm-auto-modes '("c" "c++" "python" "scala" ("elisp" "emacs-lisp")))
     octave
     plantuml
     (python :variables
             python-backend 'anaconda
             python-test-runner '(pytest)
             ;; python-enable-yapf-format-on-save t
             )
     racket
     (ruby :variables ruby-version-manager 'chruby)
     ;; rust
     scheme
     semantic-web
     ;; semweb
     sql
     (typescript :variables
                 typescript-fmt-on-save nil
                 typescript-fmt-tool 'typescript-formatter)
     yaml
     vimscript
     (clojure :variables clojure-enable-fancify-symbols t)
     html
     csv
     ;; restructuredtext
     ;; ---readers---
     dash
     deft
     elfeed
     pdf
     ;; ---source-control---
     (git :variables
          git-magit-status-fullscreen t)
     github
     (version-control :variables
                      version-control-diff-tool 'diff-hl)
     ;; ---tags---
     (gtags :disabled-for clojure emacs-lisp javascript latex python shell-scripts ess)
     ;; ---colors---
     (colors :variables
             colors-enable-nyan-cat-progress-bar t)
     theming
     ;; ---tools---
     command-log
     docker
     imenu-list
     pandoc
     pass
     prodigy
     (ranger :variables ranger-show-preview t)
     (rebox :variables rebox-enable-in-text-mode t)
     (restclient :variables restclient-use-org t)
     (shell :variables
            shell-default-shell 'eshell
            shell-enable-smart-eshell t)
     ;; sphinx
     systemd
     tern
     web-beautify
     ;; ---veb-services---
     search-engine
     ;; ---others---
     (spacemacs-layouts :variables layouts-enable-autosave nil
                        layouts-autosave-delay 300)
     )
   dotspacemacs-additional-packages '(
                                      nodejs-repl
                                      youdao-dictionary
                                      chinese-yasdcv
                                      req-package
                                      blog-admin
                                      ob-ipython
                                      pangu-spacing
                                      linum-off
                                      editorconfig
                                      emmet-mode
                                      crux
                                      emms
                                      company-math
                                      org-edit-latex
                                      embrace
                                      evil-embrace
                                      ov
                                      cliphist
                                      el-get
                                      )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(exec-path-from-shell)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(
                         spacemacs-light
                         solarized-light
                         spacemacs-dark
                         leuven
                         solarized-dark
                         monokai
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '(
                               "Fira Mono"
                               ;; "Inconsolata"
                               ;; "Droid Sans Mono"
                               ;; "Ubuntu Mono"
                               ;; "Source Code Pro"
                               ;; "DejaVu Sans Mono"
                               ;; "Source Han Sans CN"
                               ;; "WenQuanYi Micro Hei Mono"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 20
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-smart-closing-parenthesis t
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("pt" "ag" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  (setq configuration-layer--elpa-archives
      '(("melpa-cn" . "https://elpa.zilongshanren.com/melpa/")
        ("org-cn"   . "https://elpa.zilongshanren.com/org/")
        ("gnu-cn"   . "https://elpa.zilongshanren.com/gnu/")))
  )

(defun dotspacemacs/user-config ()
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (require 'ob-tangle)
  (org-babel-load-file
    (expand-file-name "lengyueyang.org"
                      dotspacemacs-directory))
  )

(setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
(load custom-file 'no-error 'no-message)
