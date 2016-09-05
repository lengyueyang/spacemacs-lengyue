;;; Markdown mode
(when (configuration-layer/layer-usedp 'markdown)
  (setq auto-mode-alist (cons '("\\.text$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.md$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.mdown$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.mdt$" . gfm-mode) auto-mode-alist))
  (setq auto-mode-alist (cons '("\\.markdown$" . gfm-mode) auto-mode-alist)))

(add-to-list 'auto-mode-alist '("\\inbox.txt\\'" . org-mode))

(setq erc-nick "lengyueyang")
(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs-cn")))

(defun endless/org-ispell ()
  "Configure `ispell-skip-region-alist' for `org-mode'."
  (make-local-variable 'ispell-skip-region-alist)
  (add-to-list 'ispell-skip-region-alist '(org-property-drawer-re))
  (add-to-list 'ispell-skip-region-alist '("~" "~"))
  (add-to-list 'ispell-skip-region-alist '("=" "="))
  (add-to-list 'ispell-skip-region-alist '("^#\\+BEGIN_SRC" . "^#\\+END_SRC")))
(add-hook 'org-mode-hook #'endless/org-ispell)
