;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; dired-setting.el ---

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; sorter.el
;; (install-elisp "http://www.bookshelf.jp/elc/sorter.el")
(load "sorter.el")

;; today highlight
(defface my-face-f-2 '((t (:foreground "yellow"))) nil)
(defvar my-face-f-2 'my-face-f-2)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (concat (format-time-string "%Y-%m-%d" (current-time)) " [0-9]....") arg t))
(add-hook 'dired-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              major-mode
              (list
               '(my-dired-today-search . my-face-f-2)
               ))))

;; ls -alh
(defadvice dired-sort-order
  (around dired-sort-order-h activate)
  (ad-set-arg 0 (concat (ad-get-arg 0) "h"))
  ad-do-it
  (setq dired-actual-switches
        (dired-replace-in-string "h" "" dired-actual-switches)))

;;; dired-setting.el ends here
