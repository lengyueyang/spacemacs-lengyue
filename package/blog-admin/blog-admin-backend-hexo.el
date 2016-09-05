;;; blog-admin-backend-hexo.el --- hexo backend for blog-admin  -*- lexical-binding: t; -*-
;; Copyright (C) 2016

;; Author: code.falling@gmail.com
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(require 'ox)
(require 'blog-admin-backend)

(defvar blog-admin-backend-hexo-template-org-post "#+TITLE: %s
#+DATE: %s
#+LAYOUT: post
#+TAGS:
#+CATEGORIES:
"
  "template for hexo's org post")

(defvar blog-admin-backend-hexo-template-md-post "title: %s
date: %s
tags:
categories:
---
"
  "template for hexo's markdown post")

(defvar blog-admin-backend-hexo-posts-dir "source/_posts")
(defvar blog-admin-backend-hexo-drafts-dir "source/_drafts")

;; hexo define

(defun blog-admin-backend-hexo--scan-posts ()
  "Scan posts of hexo"
  (apply 'append
         (mapcar
          (lambda (append-path)
            "scan files with append-path"
            (directory-files (blog-admin-backend--full-path append-path) t "^.*\\.\\(org\\|md\\|markdown\\)$"))
          (list blog-admin-backend-hexo-posts-dir blog-admin-backend-hexo-drafts-dir)
          )))

(defun blog-admin-backend-hexo--is-in-drafts? (post)
  "Return whether is post in drafts"
  (s-starts-with?
   (blog-admin-backend--full-path blog-admin-backend-hexo-drafts-dir) post))

(defun blog-admin-backend-hexo--read-info (post)
  "Read info of hexo post"
  (let ((info (if (s-ends-with? ".org" post)
                  ;; org post
                  (blog-admin-backend--read-org-info post)
                ;; markdown post
                (blog-admin-backend--read-md-info post))))
    ;; read if publish
    (if (blog-admin-backend-hexo--is-in-drafts? post)
        ;; then
        (plist-put info :publish "NO")
      ;; else
      (plist-put info :publish "YES")
      )
    ;; format datetime
    (plist-put info :date (blog-admin-backend--format-datetime (plist-get info :date)))
    ))

(defun blog-admin-backend-hexo--file-path (name in-drafts?)
  (f-join (blog-admin-backend--full-path 
           (if in-drafts? blog-admin-backend-hexo-drafts-dir
             blog-admin-backend-hexo-posts-dir))
          name))

(defun blog-admin-backend-hexo--exchange-place (path)
  "Drafts->posts, posts->drafts"
  (if (f-exists? path)
      (let* ((name (f-filename path)))
        (if (blog-admin-backend-hexo--is-in-drafts? path)
            ;; drafts->posts
            (f-move path
                    (blog-admin-backend-hexo--file-path name nil))
          ;; posts->drafts
          (f-move path
                  (blog-admin-backend-hexo--file-path name t))
          ))))

(defun blog-admin-backend-hexo--publish-or-unpublish ()
  "Switch between publish and drafts"
  (interactive)
  (let* ((post (blog-admin--table-current-file))
         (dirpath (f-no-ext post)))
    (blog-admin-backend-hexo--exchange-place post)
    (blog-admin-backend-hexo--exchange-place dirpath)
    (blog-admin-refresh)
    ))

(defun blog-admin-backend-hexo-new-post (filename)
  "New hexo post"
  (interactive "sPost's filename(new-post.org, new-post.md etc):")
  (if (or (s-ends-with? ".org" filename) (s-ends-with? ".md" filename))
      (progn
        (if blog-admin-backend-new-post-with-same-name-dir
            (f-mkdir (blog-admin-backend-hexo--file-path (f-no-ext filename) blog-admin-backend-new-post-in-drafts)))
        (find-file (blog-admin-backend-hexo--file-path filename blog-admin-backend-new-post-in-drafts))
        (insert
         (format
          (if (s-ends-with? ".org" filename) blog-admin-backend-hexo-template-org-post blog-admin-backend-hexo-template-md-post)
          (f-no-ext filename)
          (format-time-string "%Y-%m-%d" (current-time))
          ))
        (save-buffer)
        (kill-buffer)
        (blog-admin-refresh))
    (message "Post's filename must end with .org or .md!")
    ))

(blog-admin-backend-define 'hexo
                           '(:scan-posts-func
                             blog-admin-backend-hexo--scan-posts
                             :read-info-func
                             blog-admin-backend-hexo--read-info
                             :publish-unpublish-func
                             blog-admin-backend-hexo--publish-or-unpublish
                             :new-post-func
                             blog-admin-backend-hexo-new-post
                             ))

(provide 'blog-admin-backend-hexo)
;;; blog-admin-backend-hexo.el ends here
