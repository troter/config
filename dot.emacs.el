;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; My emacs.el.
;;; ============

;;; utilitys 
;;; ========
;; platform predicate
(defun windows-ntp () (eq system-type 'windows-nt))
(defun meadowp () (featurep 'meadow))
(defun carbon-emacsp () (featurep 'carbon-emacs-package))

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
