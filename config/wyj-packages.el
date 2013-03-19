;; -*- coding: utf-8 -*-
(require 'wyj-utils)

(require 'package)
;; MELPA Packages Repositories http://melpa.milkbox.net/
;; 不知怎的，这个下载就是TMD有问题
;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;   )

;; Marmalade Packages Repositories http://marmalade-repo.org/
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)


;;tabbar
(require 'tabbar)
(tabbar-mode t)
(global-set-key (kbd "C--") 'tabbar-backward-group)
(global-set-key (kbd "C-=") 'tabbar-forward-group)
(global-set-key (kbd "C-1") 'tabbar-backward)  
(global-set-key (kbd "C-2") 'tabbar-forward)


;;ibuffer
(autoload 'ibuffer "ibuffer" "ibuffer mode" t)
(global-set-key (kbd "C-x C-b") 'ibuffer)


;;yasnippet
(require 'yasnippet)
(yas--initialize)
(yas-load-directory "~/.emacs.d/elpa/yasnippet-0.8.0/snippets")
;; 和emacs-for-python里的yasnippet冲突，暂时注掉
;; Sat Jan 26 00:50:16 2013


;;window-number
(autoload 'window-number-mode "window-number"
  "A global minor mode that enables selection of windows according to
numbers with the C-x C-j prefix.  Another mode,
`window-number-meta-mode' enables the use of the M- prefix."
  t)

(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)

(window-number-mode 1)
(window-number-meta-mode 1)


;;smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(smex-auto-update 60)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; auto-complete(神器!)
;; 配置文件位于modes文件夹下


;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-0") 'er/expand-region)


;; highlight-symbol
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(control meta f3)] 'highlight-symbol-query-replace)


;; magit
(autoload 'magit-status "magit" "magit" t)


;; htmlize
(require 'htmlize)


;; tempbuf
(wyj/plugin:prepend-to-load-path "tempbuf-mode")
(require 'tempbuf)
(add-hook 'help-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'grep-mode-hook 'turn-on-tempbuf-mode)
;(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)

;(add-hook 'custom-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'w3-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'Man-mode-hook 'turn-on-tempbuf-mode)
;(add-hook 'view-mode-hook 'turn-on-tempbuf-mode)

;(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)


;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode 1)


;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


;; wrap-region
;; https://github.com/rejeep/wrap-region/
(require 'wrap-region)
(wrap-region-mode t)


;; ace-jump
;; http://blog.csdn.net/pfanaya/article/details/7611297
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; I also use SPC in eval mode to direct start this mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;; paredit 王垠推荐的
;; 强制删掉括号C-u DEL，强制输入括号C-q (或C-q )
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-strucurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))

;; 以下配置取自http://www.emacswiki.org/emacs/ParEdit
;; ParEdit and "Electric RETURN"
;; 在右括号末尾按 C-) 可以使下一行括号自动补上来
(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
  return.")
(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
	(save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))
;; Using local-set-key in a mode-hook is a better idea.
;(global-set-key (kbd "RET") 'electrify-return-if-match)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode t)
	    (turn-on-eldoc-mode)
	    (eldoc-add-command
	     'paredit-backward-delete
	     'paredit-close-round)
	    (local-set-key (kbd "RET") 'electrify-return-if-match)
	    (eldoc-add-command 'electrify-return-if-match)
	    (show-paren-mode t)))

;; autopair
;; 参考mbriggs
;; emacswiki上说，貌似有了paredit，就可以替代autopair了
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

(add-hook 'term-mode-hook
          (lambda ()
            (setq autopair-dont-activate t)))


;; keywiz 一个小游戏 用来训练快捷键熟悉程度
(require 'keywiz)


;; mark-multiple
;; 看这个video http://emacsrocks.com/e08.html
(require 'mark-multiple)
(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)

;; google-translate
(load-file "~/.emacs.d/plugins/cedet-1.1/common/cedet.el")

(require 'google-translate)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)


;; xah_lee
;; lookup-word-on-internet
(wyj/plugin:prepend-to-load-path "xah_lee")
(autoload 'lookup-google "lookup-word-on-internet" "Lookup in browser" t)
(autoload 'lookup-wikipedia "lookup-word-on-internet" "Lookup in browser" t)
(autoload 'lookup-word-dict-org "lookup-word-on-internet" "Lookup in browser" t)
(autoload 'lookup-word-definition "lookup-word-on-internet" "Lookup in browser" t)
(autoload 'lookup-wiktionary "lookup-word-on-internet" "Lookup word in browser" t)
(autoload 'lookup-php-ref "lookup-word-on-internet" "Lookup word in browser" t)
(global-set-key (kbd "<f1> 1") 'lookup-google)
(global-set-key (kbd "<f1> 2") 'lookup-wikipedia)
(global-set-key (kbd "<f1> 3") 'lookup-word-definition)


;; weibo
;; http://emacser.com/weibo.htm
;; weibo和CEDET有冲突，暂时先放到这，同时注释掉init-cedet这句话
;; (load-file "~/.emacs.d/plugins/cedet-1.1/common/cedet.el")
(wyj/plugin:prepend-to-load-path "weibo")
(require 'weibo)


;; nxhtml
;; http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
(wyj/plugin:prepend-to-load-path "nxhtml")
(load "autostart.el")
