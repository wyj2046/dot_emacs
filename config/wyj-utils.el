;; -*- coding: utf-8 -*-

;; some const variabel
(defconst wyj/os:windowsp (eq system-type 'windows-nt)
  "if current operation system is windows system")

(defconst wyj/os:win32p (and wyj/os:windowsp
			     (not (getenv "PROGRAMW6432")))
  "if current operation system is windows 32bit version")

(defconst wyj/os:win64p (and wyj/os:windowsp
			     (getenv "PROGRAMW6432"))
  "if current operation system is windows 64bit verison")


(defconst wyj/host:HOMEp (string-equal system-name "RAPID-THINK")
  "if the current host is my laptop")

(defconst wyj/host:OFFICEp (string-equal system-name "SINA-PC")
  "if the current host is my SINA-PC")

(defconst wyj/host:ubuntup (string-equal system-name "rapid")
  "if the current host is rapid")

(defconst wyj/host:home_ubuntup (string-equal system-name "rapid")
  "if the current host is rapid")


(defconst wyj/plugin:base-directory "~/.emacs.d/plugins"
  "The root directory that all the extra plugin will put in")

(defconst wyj/elpa:base-directory "~/.emacs.d/elpa"
  "The root directory that all the package system plugin will put in")

;; `load-path' is a list of directories where Emacs Lisp libraries
;; (`.el' and `.elc' files) are installed.
;;
;; `exec-path' is different: it is a list of directories where
;; executable programs are installed.
;;
;; Shouldn't be `exec-path' and `PATH' achieve the same goal under
;; Emacs?
;;
;; No. `exec-path' is used by Emacs to search for programs it runs
;; directly.  But `M-x grep' does not run `grep.exe' directly; it runs
;; the shell passing it a command that invokes `grep'. So it's the
;; shell that needs to find `grep.exe', and it uses PATH, of course,
;; not `exec-path'.
;;
;; So the right thing to do when you install a new program, in order
;; for Emacs to find it, is *both* to update `exec-path' *and* update
;; `PATH'. This is because some Emacs features invoke programs
;; directly, while others do that through the shell or some other
;; intermediary programs.
(defun wyj/prepend-to-exec-path (path)
  "prepend the path to the emacs intenral `exec-path' and \"PATH\" env variable.
Return the updated `exec-path'"
  (setenv "PATH" (concat (expand-file-name path)
			 path-separator
			 (getenv "PATH")))
  (setq exec-path
	(cons (expand-file-name path)
	      exec-path)))

(defun wyj/log:message (message &rest args)
  "Display the warning message into *init* buffer"
  (display-warning 'wyj-config (apply 'format message args) :warning "*wyj-config*"))

;; Prepend a path to the begin of the `load-path'
(defun wyj/prepend-to-load-path (path)
  "prepend the PATH to the head of the `load-path', return updated load-path"
  (add-to-list 'load-path path))

(defun wyj/plugin:expand-file-name (relative-path &optional base-directory)
  "Expand the RELATIVE-PATH according to BASE-DIRECTORY.
If BASE-DIRECTORY is nil, use `wyj/plugin:base-directory'"
  (expand-file-name relative-path (or base-directory wyj/plugin:base-directory)))

(defun wyj/elpa:expand-file-name (relative-path &optional base-directory)
  "Expand the RELATIVE-PATH according to BASE-DIRECTORY.
If BASE-DIRECTORY is nil, use `wyj/elpa:base-directory'"
  (expand-file-name relative-path (or base-directory wyj/elpa:base-directory)))

(defun wyj/plugin:prepend-to-load-path (plugin-folder-name &optional base-directory)
  "Prepend the plugin in BASE-DIRECTORY in the `load-path', so that you can use `require' later.
If BASE-DIRECTORY is nil, use `wyj/plugin:base-directory' as base director.
This function will also check if the plugin folder exist before prepend to `load-path'."
  (let ((full-path (wyj/plugin:expand-file-name plugin-folder-name base-directory)))
    (cond
     ((file-exists-p full-path)
      (wyj/prepend-to-load-path full-path)
      full-path)
     (t
      (wyj/log:message "plugin dir [%s] does not exits, loading possibly failed" full-path)
      nil))))

(defun wyj/elpa:prepend-to-load-path (plugin-folder-name &optional base-directory)
  "Prepend the plugin in BASE-DIRECTORY in the `load-path', so that you can use `require' later.
If BASE-DIRECTORY is nil, use `wyj/elpa:base-directory' as base director.
This function will also check if the plugin folder exist before prepend to `load-path'."
  (let ((full-path (wyj/elpa:expand-file-name plugin-folder-name base-directory)))
    (cond
     ((file-exists-p full-path)
      (wyj/prepend-to-load-path full-path)
      full-path)
     (t
      (wyj/log:message "elpa dir [%s] does not exits, loading possibly failed" full-path)
      nil))))


(defun wyj/delete-trailing-whitespace-when-save ()
  "add local hook, so that when save action happens, auto remove the trailing whitespaces"
  (add-hook 'local-write-file-hooks
	    (lambda()
	      (save-excursion
		(delete-trailing-whitespace)))))


(defun wyj/kill-buffer-may-have-clients ()
  "The same as kill buffer, but if this buffer is open via emacsclient, also notify the server to close connection"
  (interactive)
  (if (and (boundp 'server-buffer-clients)
	   server-buffer-clients)
      (server-kill-buffer))
  (kill-buffer (current-buffer)))


(provide 'wyj-utils)
