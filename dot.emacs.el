;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; My emacs.el.
;;; ============

;;; utilitys 
;;; ========

;; refer: http://d.hatena.ne.jp/tomoya/20090807/1249601308
(defun x->bool (elt) (not (not elt)))

;; emacs-version predicates
(dolist (ver '("22" "23" "23.0" "23.1" "23.2"))
  (set (intern (concat "emacs" ver "-p"))
       (if (string-match (concat "^" ver) emacs-version)
           t nil)))

;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
      linux-p   (eq system-type 'gnu/linux)
      colinux-p (when linux-p
                  (let ((file "/proc/modules"))
                    (and
                     (file-readable-p file)
                     (x->bool
                      (with-temp-buffer
                        (insert-file-contents file)
                        (goto-char (point-min))
                        (re-search-forward "^cofuse\.+" nil t))))))
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      meadow-p  (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

;; refer: http://www.sodan.org/~knagano/emacs/dotemacs.html
(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))

;; string utility
(defun strings-join (strings &optional separator)
  (if (and separator strings)
      (let ((rs (list (car strings)))
            (ss (cdr strings)))
        (while ss
          (setq rs (cons (car ss) (cons separator rs)))
          (setq ss (cdr ss)))
        (setq strings (reverse rs))))
  (apply 'concat strings))


;; directory
(defconst install-elisp-directory "~/.emacs.d/elisp")

;;; Path settings.
;;; ===================
(add-to-list 'load-path "~/.emacs.d/conf")
(add-to-list 'load-path install-elisp-directory)
(add-to-list 'load-path "~/.emacs.d/auto-install")

;;; Loading.
;;; ========
;; installer
(load "installer-settings")

;; basis
(load "language-settings")
(load "input-method-settings")
(load "look-and-feel-settings")
(load "misc-settings")
(load "carbon-emacs-settings")
(load "windows-settings")

;; others
(load "buffer-settings.el")
(load "dired-settings.el")
(load "term-settings.el")
(load "mode-settings.el")
(load "anything-settings.el")

;;; Key binding configuration.
;;; ==========================
;(global-set-key "\C-z" 'undo)                       ;;UNDO
(global-set-key [f1] 'help-for-help)
(global-set-key "\C-h" 'backward-delete-char) ;;Ctrl-Hでバックスペース
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))
(define-key global-map (kbd "C-;") 'anything)

;;; End of .emacs.el
