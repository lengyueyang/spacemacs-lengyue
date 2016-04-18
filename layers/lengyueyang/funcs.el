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


;; copy from https://github.com/zilongshanren/spacemacs-private/blob/develop/layers%2Fzilongshanren%2Ffuncs.el
(defvar wc-regexp-chinese-char-and-punc
  (rx (category chinese)))
(defvar wc-regexp-chinese-punc
  "[。，！？；：「」『』（）、【】《》〈〉※—]")
(defvar wc-regexp-english-word
  "[a-zA-Z0-9-]+")

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

(defun lengyueyang/start-erc ()
  "Connect to IRC"
  (interactive)
  (when (y-or-n-p "Do you want to start IRC? ")
    (erc :server "irc.freenode.net" :port 6666 :nick erc-nick)))


(defun lengyueyang//notify (title message)
  (let ((terminal-notifier-command (executable-find "terminal-notifier")))
    (start-process "terminal-notifier"
                   "*terminal-notifier*"
                   terminal-notifier-command
                   "-title" title
                   "-message" message
                   "-activate" "org.gnu.Emacs"
                   "-sender" "org.gnu.Emacs")))

(defun lengyueyang//org-archive-tasks (prefix)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   (format "/%s" prefix) 'file))


(defun lengyueyang/org-archive-all-tasks ()
  (interactive)
  (lengyueyang//org-archive-tasks "DONE")
  (lengyueyang//org-archive-tasks "CANCELLED")
  (lengyueyang//org-archive-tasks "FIXED")
  )



