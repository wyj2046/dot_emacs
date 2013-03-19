;; -*- coding: utf-8 -*-
;; 参考winterTT
;; (require 'ecb-autoloads)
;; ;;error reports if i do not set this var
;; (setq stack-trace-on-error t)           
;; ;;disable tips, kinda noisy
;; (setq ecb-tip-of-the-day nil)
;; ;;use 'image style, i like this than 'ascii-guide
;; (setq ecb-tree-buffer-style 'image)
;; ;;do not remove record in history when kill-buffer
;; (setq ecb-kill-buffer-clears-history nil)
;; ;;bucket the history by major-mode
;; (setq ecb-history-make-buckets 'mode)
;; ;use manually update, c-c . r
;; ;(setq ecb-analyse-buffer-sync nil)
;; ;; start ecb in a new frame
;; (setq ecb-new-ecb-frame nil)
;; ;; use mouse 1 instead of mouse 2
;; (setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1)
;; ;; compile window
;; ;(setq ecb-compile-window-height nil)
;; ;; whether show file in directory-buffer
;; ;(setq ecb-show-sources-in-directories-buffer 'always)
;; (setq ecb-show-sources-in-directories-buffer
;;       (list "left7" "left13" "left14" "left15"))


;; (defun wttr/ecb:smart-switch-layout (layout-name)
;;   "If the layout name is not current layout, open/swtich to it.
;; Other close current ecb layout."
;;   (if (and (boundp 'ecb-minor-mode) ecb-minor-mode)
;;       (if (string-equal ecb-layout-name layout-name)
;;           (ecb-deactivate)
;;         (ecb-layout-switch layout-name))
;;     (progn
;;       (setq ecb-layout-name layout-name)
;;       (ecb-activate))))

;; (defun wttr/ecb:left-method-layout ()
;;   (interactive)
;;   (wttr/ecb:smart-switch-layout "left9"))
  

;; (defun wttr/ecb:left-directory-layout ()
;;   (interactive)
;;   (wttr/ecb:smart-switch-layout "left13"))

    
;; (defun wttr/ecb:left-directory-method-layout ()
;;   "Open left directory window, default to left15 layout"
;;   (interactive)
;;   (wttr/ecb:smart-switch-layout "left15"))

;; (global-set-key (kbd "<f11>") 'wttr/ecb:left-directory-layout)
;; (global-set-key (kbd "<f10>") 'wttr/ecb:left-method-layout)



;; 参考Meteor Liu
(require 'ecb-autoloads nil 'noerror)
(unless (boundp 'stack-trace-on-error)
  (defvar stack-trace-on-error nil))
(when (fboundp 'ecb-minor-mode)
  (defvar ecb-minor-mode nil)
  (setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1
        ecb-source-path '("/")
        ecb-layout-name 'left3
        ecb-toggle-layout-sequence '("left3"
                                     "left8"
                                     "left-analyse"
                                     "left-symboldef")
        ;; ecb-windows-width 0.25
        ecb-compile-window-height 0.15
        ecb-compile-window-width 'edit-window
        ecb-compile-window-temporally-enlarge 'after-selection
        ;; ecb-enlarged-compilation-window-max-height 0.8
        ecb-tip-of-the-day nil
        ecb-auto-compatibility-check nil))
(eval-after-load "ecb"
  '(progn
     (setq ecb-compilation-buffer-names
           (append ecb-compilation-buffer-names '(("*Process List*")
                                                  ("*Proced*")
                                                  (".notes")
                                                  ("*appt-buf*")
                                                  ("*Compile-Log*")
                                                  ("*etags tmp*")
                                                  (" *svn-process*")
                                                  ("*svn-info-output*")
                                                  ("*Python Output*")
                                                  ("*Org Agenda*")
                                                  (" *EMMS Playlist*")
                                                  ("*Moccur*")
                                                  ("*Directory"))))
     (setq ecb-compilation-major-modes
           (append ecb-compilation-major-modes '(change-log-mode
                                                 calendar-mode
                                                 diary-mode
                                                 diary-fancy-display-mode
                                                 xgtags-select-mode
                                                 svn-status-mode
                                                 svn-info-mode
                                                 svn-status-diff-mode
                                                 svn-log-view-mode
                                                 svn-log-edit-mode
                                                 erc-mode
                                                 gud-mode)))))
