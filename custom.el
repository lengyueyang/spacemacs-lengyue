;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-auto-local "/home/lengyue/MEGA/Emacs-lengyue/Data-collection/tex-auto")
 '(TeX-engine (quote xetex))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(emms-directory "~/.emacs.d/emms/s")
 '(evil-shift-width 10)
 '(large-file-warning-threshold 210000000)
 '(magit-log-section-arguments (quote ("--decorate" "-n256")))
 '(ob-http:max-time 60)
 '(ob-ipython-driver-hostname "127.0.0.1")
 '(org-agenda-files
   (quote
    ("~/Emacs-lengyue/Data scientist/Machine learning/ML Notes-lengyue.org" "/home/lengyue/Emacs-lengyue/GTD-lengyue/GTD-lengyue.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Bioinformatics.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Booklists.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Bookmark.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Data scientist.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Elfeed.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Emacs.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Life.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Linux.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Notes.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Programming.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Research.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Resume.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Tools.org" "/home/lengyue/Emacs-lengyue/Wiki-lengyue/Wiki-lengyue.org")))
 '(org-agenda-skip-scheduled-if-deadline-is-shown (quote repeated-after-deadline))
 '(org-babel-python-command "python")
 '(org-edit-latex-create-master nil)
 '(org-export-headline-levels 4)
 '(org-format-latex-options
   (quote
    (:foreground default :background "Transparent" :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")
                 :justify center)))
 '(org-image-actual-width (quote (800)))
 '(org-latex-default-packages-alist
   (quote
    (("T1" "fontenc" t
      ("pdflatex"))
     ("" "graphicx" t)
     ("" "grffile" t)
     ("" "longtable" nil)
     ("" "wrapfig" nil)
     ("" "rotating" nil)
     ("normalem" "ulem" t)
     ("" "amsmath" t)
     ("" "textcomp" t)
     ("" "amssymb" t)
     ("" "capt-of" nil)
     ("" "hyperref" nil))))
 '(org-latex-logfiles-extensions
   (quote
    ("aux" "bcf" "blg" "fdb_latexmk" "fls" "figlist" "idx" "log" "nav" "out" "ptc" "run.xml" "snm" "toc" "vrb" "xdv" "bbl" "el")))
 '(org-pomodoro-length 1)
 '(org-pomodoro-short-break-length 1)
 '(org-pretty-entities t)
 '(org-preview-latex-default-process (quote imagemagick))
 '(org-preview-latex-image-directory "/home/lengyue/MEGA/Emacs-lengyue/Data-collection/ltximg/")
 '(org-preview-latex-process-alist
   (quote
    ((dvipng :programs
             ("latex" "dvipng")
             :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
             (1.0 . 1.0)
             :latex-compiler
             ("latex -interaction nonstopmode -output-directory %o %f")
             :image-converter
             ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
     (dvisvgm :programs
              ("latex" "dvisvgm")
              :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
              (1.7 . 1.5)
              :latex-compiler
              ("latex -interaction nonstopmode -output-directory %o %f")
              :image-converter
              ("dvisvgm %f -n -b min -c %S -o %O"))
     (imagemagick :programs
                  ("latex" "convert")
                  :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                  (1.0 . 1.0)
                  :latex-compiler
                  ("xelatex -interaction nonstopmode -output-directory %o %f")
                  :image-converter
                  ("convert -density %D -trim -antialias %f -quality 100 %O")))))
 '(org-src-window-setup (quote other-window))
 '(org-startup-with-inline-images t)
 '(package-selected-packages
   (quote
    (edit-indirect hlint-refactor hindent haskell-snippets flycheck-haskell company-ghci haskell-mode company-cabal cmm-mode vagrant-tramp vagrant origami seeing-is-believing prettier-js srv ivy-pass gitignore-templates treepy graphql doom-modeline eldoc-eval shrink-path sesman dotenv-mode ttl-mode sparql-mode zeal-at-point unicode-fonts ucs-utils font-utils typo treemacs-projectile treemacs-evil treemacs pfuture systemd sql-indent slack circe oauth2 rebox2 pony-mode plantuml-mode persistent-soft list-utils password-store ox-twbs ox-gfm jabber fsm geiser erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks emojify emoji-cheat-sheet-plus counsel-dash helm-dash company-emoji ob-hy ivy-yasnippet evil-goggles magit-svn rjsx-mode magithub ghub+ apiwrap json-navigator hierarchy csv-mode vimrc-mode dactyl-mode yasnippet-snippets ruby-hash-syntax pipenv org-mime ivy-xref centered-cursor-mode cliphist ivy-rich el-get spaceline-all-the-icons all-the-icons memoize font-lock+ pippel overseer nameless ivy-rtags importmagic epc concurrent google-c-style flycheck-rtags ghub let-alist evil-cleverparens counsel-gtags counsel-css company-rtags rtags clojure-cheatsheet ov highlight-symbol evil-embrace embrace cal-china-x zenburn-theme winum unfill symon string-inflection sayid ruby-refactor test-simple loc-changes load-relative password-generator org-edit-latex ob-restclient monokai-theme marshal logito pcache fuzzy flx ace-jump-mode popwin request-deferred json-snatcher json-reformat dash-functional company-restclient know-your-http-well math-symbol-lists company-lua pyim-basedict pos-tip browse-at-remote packed pythonic avy popup deferred pyim tern ctable evil goto-chg simple-httpd solarized-theme realgud org-category-capture org-brain evil-org evil-lion cmake-ide levenshtein company-math chinese-pyim-greatdict chinese-pyim-wbdict nlinum-relative nlinum company-inf-ruby ac-inf-ruby pkg-info epl bind-map command-log-mode emms mu4e-maildirs-extension mu4e-alert crux ssh-config-mode sbt-mode scala-mode rust-mode qml-mode jinja2-mode flymake-json import-js gradle-mode malabar-mode go-mode cff cpputils-cmake dummy-h-mode c-eldoc batch-mode flymake-shell mustache-mode css-eldoc eshell-autojump multi-eshell linum-off request hydra company ob-ipython blog-admin req-package highlight gh helm-purpose org-tree-slide helm-gtags helm-css-scss flyspell-correct-helm wrap-region visual-regexp-steroids visual-regexp tiny peep-dired org-octopress orglue epic org-mac-link lispy zoutline impatient-mode helm-github-stars find-file-in-project etags-select editorconfig discover-my-major makey cmake-font-lock 4clojure chinese-yasdcv web-mode tide typescript-mode tagedit slim-mode scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restclient rbenv ranger pug-mode projectile-rails rake prodigy pdf-tools ob-http minitest lua-mode less-css-mode ibuffer-projectile haml-mode glsl-mode ggtags feature-mode engine-mode emmet-mode dockerfile-mode docker tablist docker-tramp deft company-web web-completion-data clojure-snippets clj-refactor inflections edn paredit peg cider-eval-sexp-fu cider seq queue clojure-mode chruby bundler inf-ruby yaml-mode auto-complete youdao-dictionary names chinese-word-at-point smooth-scrolling py-yapf page-break-lines org-repo-todo leuven-theme helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-gitignore helm-flyspell helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag fcitx buffer-move bracketed-paste ace-jump-helm-line swiper auctex anzu undo-tree flyspell-correct dash ht ivy-purpose window-purpose imenu-list hide-comnt anaconda-mode yasnippet magit-popup git-commit async f s with-editor skewer-mode fringe-helper git-gutter+ git-gutter julia-mode noflet powerline elfeed websocket chinese-pyim-basedict biblio-core counsel ess smartparens flycheck projectile magit js2-mode ivy graphviz-dot-mode xterm-color ws-butler window-numbering which-key volatile-highlights use-package toc-org spaceline shell-pop restart-emacs rainbow-delimiters racket-mode pyvenv py-isort pip-requirements persp-mode paradox pandoc-mode ox-pandoc orgit org-ref org-pomodoro alert org-plus-contrib open-junk-file neotree multi-term move-text markdown-toc markdown-mode magit-gitflow macrostep js2-refactor info+ indent-guide ido-vertical-mode hl-todo highlight-numbers help-fns+ helm-make helm-bibtex helm helm-core google-translate github-clone gitconfig-mode git-timemachine git-messenger git-link expand-region exec-path-from-shell evil-unimpaired evil-surround evil-search-highlight-persist evil-nerd-commenter evil-mc evil-matchit evil-magit evil-iedit-state iedit evil-exchange evil-escape eshell-prompt-extras elfeed-web elfeed-org org yapfify wgrep web-beautify vi-tilde-fringe uuidgen uimage stickyfunc-enhance srefactor spinner spacemacs-theme smex smeargle rainbow-mode rainbow-identifiers quelpa pytest pyenv-mode pcre2el parsebib parent-mode pangu-spacing org-projectile org-present org-download org-caldav org-bullets nodejs-repl mwim multiple-cursors mmm-mode magit-gh-pulls lorem-ipsum log4e livid-mode live-py-mode linum-relative link-hint key-chord json-mode js-doc ivy-hydra hy-mode hungry-delete htmlize hl-sexp highlight-parentheses highlight-indentation golden-ratio gnuplot gntp gitignore-mode github-search github-browse-file gitattributes-mode git-gutter-fringe git-gutter-fringe+ gist gh-md flyspell-correct-ivy flycheck-pos-tip flx-ido find-by-pinyin-dired fill-column-indicator fancy-battery faceup eyebrowse evil-visualstar evil-visual-mark-mode evil-tutor evil-numbers evil-lisp-state evil-indent-plus evil-ediff evil-args evil-anzu eval-sexp-fu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-z esh-help elisp-slime-nav elfeed-goodies ein dumb-jump disaster diminish diff-hl define-word cython-mode counsel-projectile company-tern company-statistics company-quickhelp company-c-headers company-auctex company-anaconda column-enforce-mode color-identifiers-mode coffee-mode cmake-mode clean-aindent-mode clang-format chinese-pyim bind-key biblio auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-pinyin ace-link ac-ispell)))
 '(python-indent-guess-indent-offset nil)
 '(python-indent-guess-indent-offset-verbose nil)
 '(python-indent-offset 4)
 '(python-shell-completion-native-enable nil)
 '(python-shell-interpreter "python")
 '(python-shell-interpreter-args "-i")
 '(safe-local-variable-values
   (quote
    ((org-download-image-dir . "~/MEGA/Kangfuzi/Data/Data_collection/kfz_img")
     (typescript-backend . tide)
     (typescript-backend . lsp)
     (javascript-backend . tern)
     (javascript-backend . lsp)
     (org-download-image-dir . "~/MEGA/Emacs-lengyue/Data-scientist/Data science/AIimg")
     (org-download-image-dir . "~/MEGA/Emacs-lengyue/Data-scientist/Data science/NKimg")
     (org-download-image-dir . "~/MEGA/Emacs-lengyue/Data-scientist/Math and Statistics Skills/MSimg")
     (org-download-image-dir . "~/MEGA/Emacs-lengyue/Data-scientist/Data science/Dsimg")
     (org-download-image-dir . "~MEGA/Emacs-lengyue/Data scientist/Math and Statistics Skills/MSimg")
     (org-download-image-dir . "~/MEGA/Emacs-lengyue/Wiki-lengyue/img")
     (org-download-image-dir . "~/Emacs-lengyue/Wiki-lengyue/img")
     (org-download-image-dir . "~/Documents/test/img")
     (org-download-image-dir . "~/Emacs-lengyue/Data scientist/Math and Statistics Skills/MSimg")
     (org-download-image-dir . "~/Emacs-lengyue/Papers/img"))))
 '(yasdcv-sdcv-dicts
   (quote
    (("jianminghy" "简明汉英词典" "powerword2007" t)
     ("jianmingyh" "简明英汉词典" "powerword2007" t)
     ("lanconghy" "懒虫简明汉英词典" nil t)
     ("lancongyh" "懒虫简明英汉词典" nil t)
     ("xdictyh" "XDICT英汉辞典" nil t)
     ("xdicthy" "XDICT汉英辞典" nil t)
     ("xiandai" "现代英汉综合大辞典" "powerword2007" t)
     ("niujing" "牛津高阶英汉双解" "oald" nil)
     ("" "英文相关词典" "powerword2007" nil)
     ("langdaohy" "朗道汉英字典5.0" "langdao" t)
     ("langdaoyh" "朗道英汉字典5.0" "langdao" t)
     ("21shiji" "21世纪英汉汉英双向词典" "21cen" nil)
     ("21shjikj" "21世纪双语科技词典" " nil" nil)
     ("" "新世纪英汉科技大词典" nil t)
     ("" "新世纪汉英科技大词典" nil t)
     ("" "现代商务汉英大词典" "powerword2007" nil)
     ("" "英汉双解计算机词典" "powerword2007" nil)
     ("" "汉语成语词典" "chengyu" t)
     ("" "高级汉语大词典" nil t)
     ("" "现代汉语词典" nil t)
     ("" "Cantonese Simp-English" nil nil)
     ("" "英汉进出口商品词汇大全" nil nil)
     ("" "中国大百科全书2.0版" nil t)
     ("" "CEDICT汉英辞典" nil nil)
     ("" "英文字根字典" nil t)
     ("" "湘雅医学专业词典" nil t)
     ("" "[七国语言]英汉化学大词典" "powerword2007" nil)
     ("" "[七国语言]英汉数学大词典" "powerword2007" nil)
     ("" "[七国语言]英汉公共大词典" "powerword2007" nil)
     ("" "[七国语言]英汉医学大词典" "powerword2007" nil)
     ("" "[七国语言]英汉信息大词典" "powerword2007" t)
     ("" "[七国语言]英汉生物学大词典" "powerword2007" t)
     ("" "[名词委审定]英汉铁道科技名词" "powerword2007" nil)
     ("" "[名词委审定]汉英细胞生物学名词" "powerword2007" t)
     ("" "[名词委审定]汉英数学名词" "powerword2007" nil)
     ("" "[名词委审定]汉英医学名词(七, 整形、美容、皮肤、康复)" "powerword2007" t)
     ("" "[名词委审定]汉英医学名词(四, 心血管病学等)" "powerword2007" t)
     ("" "[名词委审定]汉英医学名词(一, 妇产科学)" "powerword2007" t)
     ("" "[名词委审定]汉英生物化学名词" "powerword2007" t)
     ("" "[名词委审定]英汉生物化学名词" "powerword2007" t)
     ("" "[名词委审定]汉英医学名词(二, 口腔学)" "powerword2007" t)
     ("" "[名词委审定]汉英医学名词(六, 外科)" "powerword2007" t)
     ("" "[名词委审定]汉英人体解剖学名词" "powerword2007" t)
     ("" "[名词委审定]汉英药学名词" "powerword2007" t)
     ("" "[名词委审定]汉英医学名词(三, 遗传学等)" "powerword2007" t)
     ("" "[名词委审定]汉英医学名词(五, 眼科学)" "powerword2007" t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(org-agenda-done ((t (:foreground "#86dc2f" :height 1.0))))
 '(org-scheduled-today ((t (:foreground "#bc6ec5" :height 1.0)))))
