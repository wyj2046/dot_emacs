;; -*- coding: utf-8 -*-
;; 报error: Could not create connection to raw.github.com:443这个错，
;; 大爷的，原来是GitHub被封导致，参考网址http://www.newsmth.net/nForum/#!article/Python/100570解决GitHub被封问题
;; el-get参考网址https://github.com/dimitri/el-get


;; Basic Setup
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; el-get必须上网才能使？
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))


;; (el-get 'sync)


;; golden-ratio
;; https://github.com/roman/golden-ratio.el
(add-to-list 'load-path "~/.emacs.d/el-get/golden-ratio")
(require 'golden-ratio)

(golden-ratio-enable)


;; jedi
;; http://tkf.github.com/emacs-jedi/
;; 擦，还不知道怎么玩
(setq jedi:setup-keys t)
(add-hook 'python-mode-hook 'jedi:setup)
