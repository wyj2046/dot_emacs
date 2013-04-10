;; -*- coding: utf-8 -*-

(require 'cl)

(loop for file in (directory-files "~/.emacs.d/config/modes" t "\\.el$")
      do (load file nil nil t))


;;ido
(when (require 'ido "ido" t)
  (ido-mode t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-virtual-buffers t))


;;ispell
(autoload 'ispell-buffer "ispell" "spell check the current buffer" t)
(when wyj/os:windowsp
  (wyj/prepend-to-exec-path "~/.emacs.d/extra-bin/aspell/bin")
  (setq ispell-program-name "aspell"))
(setq ispell-dictionary "british")


;; linum
(require 'linum)
(setq linum-format "%4d|")

(custom-set-faces
 '(linum ((t :foreground "CadetBlue" :inherit (shadow default))))) 

(setq linum-mode-inhibit-modes-list
      '(fundamental-mode
        speedbar-mode
        help-mode
        Info-mode
        eshell-mode
        shell-mode
        erc-mode
        jabber-roster-mode
        jabber-chat-mode
        gnus-group-mode
        gnus-summary-mode
        gnus-article-mode))

(defadvice linum-on (around linum-on-inhibit-for-modes)
  "stop the load of linum mode for some major mode"
  (unless (member major-mode linum-mode-inhibit-modes-list)
    ad-do-it))

(ad-activate 'linum-on)

(global-linum-mode 1) 


;; whitespace 参考Meteor的配置
(setq whitespace-style '(face trailing lines-tail newline empty tab-mark))
(when window-system
  (setq whitespace-style (append whitespace-style '(tabs newline-mark))))
;(global-whitespace-mode t)

;; 边框提供特殊符号 Meteor帮助
(setq-default indicate-buffer-boundaries (quote left))


;; php-mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;; 参考网址http://sachachua.com/blog/2008/07/emacs-and-php-tutorial-php-mode/
;; 增加了Drupal风格的PHP缩进模式
(defun wicked/php-mode-init ()
  "Set some buffer-local variables."
  (setq case-fold-search t) 
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (setq c-basic-offset 4)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'case-label 2)
  (c-set-offset 'arglist-close 0)
  (setq php-manual-path "~/.emacs.d/plugins/php_manual")
  (setq php-completion-file "~/.emacs.d/elpa/php-mode-1.5.0/php-completion-file")
  (setq tags-file-name "~/project/recommend/TAGS") ;让emacs自动读取tag文件内容
  (define-key php-mode-map
    [(control tab)]
    'php-complete-function)  
  )
(add-hook 'php-mode-hook 'wicked/php-mode-init)


;; 参考网址http://my.oschina.net/u/874560/blog/91955 第8部分
;; win7在emacs里运行php
(defun php-run ()
  (interactive)
  (message buffer-file-name)
  (shell-command
   (concat "D:/www/PHP/php.exe -f \""
	   (buffer-file-name)
	   "\"")))
;;这里是绑定函数到快捷键C+c r
(defun my-php-mode()
  (define-key php-mode-map [(control c) (r)] 'php-run)
  ;; (define-key php-mode-map [(control c) (d)] 'php-debug)
  ;; (hs-minor-mode t)
  ;; (linum-mode t)
  )
(add-hook 'php-mode-hook 'my-php-mode)


;; flymake-php
(require 'flymake-php)
(add-hook 'php-mode-hook 'flymake-php-load)


(provide 'wyj-modes)
