;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; term-setting.el ---

(setq elscreen-prefix-key "\C-z")
(setq elscreen-display-tab nil)
(load "elscreen" t)

;; term
;; ----
(add-hook 'term-mode-hook '(lambda ()
                             (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))
                             (define-key term-raw-map "\C-p" 'previous-line)
                             (define-key term-raw-map "\C-n" 'next-line)
                             (term-set-escape-char ?\C-x)))

;; shell
;; -----
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; use zsh
(when windows-p
  ;; use cygwin zsh
  (setq explicit-shell-file-name "zsh")
  (setq shell-file-name "sh")
  (setq shell-command-switch "-c")
  (modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan-unix)))

;;; term-setting.el ends here
