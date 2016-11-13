;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote xetex))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(large-file-warning-threshold 210000000)
 '(magit-log-section-arguments (quote ("--decorate" "-n256")))
 '(org-agenda-files
   (quote
    ("/media/My Data/DCH/CPG/肺癌临床路径/肺癌临床路径.org" "/home/lengyue/Emacs-lengyue/GTD-lengyue/GTD-lengyue.org")))
 '(org-babel-python-command "python")
 '(org-pomodoro-length 1)
 '(org-pomodoro-short-break-length 1)
 '(package-selected-packages
   (quote
    (company ob-ipython blog-admin req-package highlight gh helm-purpose org-tree-slide helm-gtags helm-css-scss flyspell-correct-helm wrap-region visual-regexp-steroids visual-regexp tiny peep-dired org-octopress orglue epic org-mac-link lispy zoutline impatient-mode helm-github-stars find-file-in-project etags-select editorconfig discover-my-major makey cmake-font-lock 4clojure chinese-yasdcv web-mode tide typescript-mode tagedit slim-mode scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restclient rbenv ranger pug-mode projectile-rails rake prodigy pdf-tools ob-http minitest lua-mode less-css-mode ibuffer-projectile haml-mode glsl-mode ggtags feature-mode engine-mode emmet-mode dockerfile-mode docker tablist docker-tramp deft company-web web-completion-data clojure-snippets clj-refactor inflections edn paredit peg cider-eval-sexp-fu cider seq queue clojure-mode chruby bundler inf-ruby yaml-mode auto-complete youdao-dictionary names chinese-word-at-point smooth-scrolling py-yapf page-break-lines org-repo-todo leuven-theme helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-gitignore helm-flyspell helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag fcitx buffer-move bracketed-paste ace-jump-helm-line swiper auctex anzu undo-tree flyspell-correct dash ht ivy-purpose window-purpose imenu-list hide-comnt anaconda-mode yasnippet magit-popup git-commit async f s with-editor skewer-mode fringe-helper git-gutter+ git-gutter julia-mode noflet powerline elfeed websocket chinese-pyim-basedict biblio-core counsel ess smartparens flycheck projectile magit js2-mode ivy graphviz-dot-mode xterm-color ws-butler window-numbering which-key volatile-highlights use-package toc-org spaceline shell-pop restart-emacs rainbow-delimiters racket-mode pyvenv py-isort pip-requirements persp-mode paradox pandoc-mode ox-pandoc orgit org-ref org-pomodoro alert org-plus-contrib open-junk-file neotree multi-term move-text markdown-toc markdown-mode magit-gitflow macrostep js2-refactor info+ indent-guide ido-vertical-mode hl-todo highlight-numbers help-fns+ helm-make helm-bibtex helm helm-core google-translate github-clone gitconfig-mode git-timemachine git-messenger git-link expand-region exec-path-from-shell evil-unimpaired evil-surround evil-search-highlight-persist evil-nerd-commenter evil-mc evil-matchit evil-magit evil-iedit-state iedit evil-exchange evil-escape eshell-prompt-extras elfeed-web elfeed-org org yapfify wgrep web-beautify vi-tilde-fringe uuidgen uimage stickyfunc-enhance srefactor spinner spacemacs-theme smex smeargle rainbow-mode rainbow-identifiers quelpa pytest pyenv-mode pcre2el parsebib parent-mode pangu-spacing org-projectile org-present org-download org-caldav org-bullets nodejs-repl mwim multiple-cursors mmm-mode magit-gh-pulls lorem-ipsum log4e livid-mode live-py-mode linum-relative link-hint key-chord json-mode js-doc ivy-hydra hy-mode hungry-delete htmlize hl-sexp highlight-parentheses highlight-indentation golden-ratio gnuplot gntp gitignore-mode github-search github-browse-file gitattributes-mode git-gutter-fringe git-gutter-fringe+ gist gh-md flyspell-correct-ivy flycheck-pos-tip flx-ido find-by-pinyin-dired fill-column-indicator fancy-battery faceup eyebrowse evil-visualstar evil-visual-mark-mode evil-tutor evil-numbers evil-lisp-state evil-indent-plus evil-ediff evil-args evil-anzu eval-sexp-fu ess-smart-equals ess-R-object-popup ess-R-data-view eshell-z esh-help elisp-slime-nav elfeed-goodies ein dumb-jump disaster diminish diff-hl define-word cython-mode counsel-projectile company-tern company-statistics company-quickhelp company-c-headers company-auctex company-anaconda column-enforce-mode color-identifiers-mode coffee-mode cmake-mode clean-aindent-mode clang-format chinese-pyim bind-key biblio auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-pinyin ace-link ac-ispell)))
 '(python-shell-completion-native-enable nil)
 '(python-shell-interpreter "python")
 '(python-shell-interpreter-args "-i")
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
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
