; -*- coding: utf-8 -*-
(require 'wyj-utils)

;; Color Theme
(wyj/plugin:prepend-to-load-path "color-theme-6.6.0")
(require 'color-theme)

;; Choose concrete color-theme
;; (require 'color-theme-ahei)
;; (color-theme-ahei)

;; (require 'color-theme-subdued)
;; (color-theme-subdued)

;; (require 'color-theme-blackboard)
;; (color-theme-blackboard)

(require 'color-theme-molokai)
(color-theme-molokai)

;; (color-theme-initialize)  ;;对于内置theme，要加这句话
;; (color-theme-blue-mood)


;; Linux下
;; 全屏
(when wyj/host:home_ubuntup
    (defun my-fullscreen ()
      (interactive)
      (x-send-client-message
       nil 0 nil "_NET_WM_STATE" 32
       '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
  (global-set-key [f6] 'my-fullscreen)
  ;; 启动时全屏
  (my-fullscreen)
  )


;;最大化
(when wyj/host:home_ubuntup
    (defun my-maximized-horz ()
      (interactive)
      (x-send-client-message
       nil 0 nil "_NET_WM_STATE" 32
       '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
  (defun my-maximized-vert ()
    (interactive)
    (x-send-client-message
     nil 0 nil "_NET_WM_STATE" 32
     '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
  (defun my-maximized ()
    (interactive)
    (x-send-client-message
     nil 0 nil "_NET_WM_STATE" 32
     '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    (interactive)
    (x-send-client-message
     nil 0 nil "_NET_WM_STATE" 32
     '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
  ;; 启动时最大化
  ;; (my-maximized)
  )


;;Win下的全屏
;; (if wyj/host:HOMEp
;;     (w32-send-sys-command 61488))


;; setup startup window size
(when wyj/os:windowsp
  (defun wyj/w32-restore-frame ()
    "Restore a minimized frame"
    (interactive)
    (w32-send-sys-command 61728))

  (defun wyj/w32-maximize-frame ()
    "Maximize the current frame"
    (interactive)
    (w32-send-sys-command 61488))
  (wyj/w32-maximize-frame)    ;; 启动时最大化
  )


;; ;; idle use zone mode
;; (autoload 'zone-when-idle "zone" nil t)
;; (zone-when-idle 600)
;; ;; zone-pgm-stress will destroy the clipboard
;; (setq zone-programs (append zone-programs nil))
;; (setq zone-programs (remq 'zone-pgm-stress zone-programs))
;; (setq zone-programs (remq 'zone-pgm-stress-destress zone-programs))
;; (setq zone-programs (remq 'zone-pgm-dissolve zone-programs))

(provide 'wyj-ui)
