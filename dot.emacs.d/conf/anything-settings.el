;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; anything-setting.el ---

;; (install-elisp-from-emacswiki "auto-complete")
(require 'auto-complete)
(global-auto-complete-mode t)

;; (auto-install-batch "anything")
(require 'anything)
(setq anything-sources
      '(anything-c-source-buffers+
	anything-c-source-colors
	anything-c-source-recentf
	anything-c-source-man-pages
	anything-c-source-emacs-commands
	anything-c-source-emacs-functions
	anything-c-source-files-in-current-dir
	))

;; (install-elisp-from-emacswiki "ac-anything")
(require 'ac-anything)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)

(require 'yasnippet)
(require 'anything-c-yasnippet)
(setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
(global-set-key (kbd "C-c y") 'anything-c-yas-complete) ;C-c yで起動 (同時にお使いのマイナーモードとキーバインドがかぶるかもしれません)
(yas/initialize)
(yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets/") ;snippetsのディレクトリを指定
(add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
(add-to-list 'yas/extra-mode-hooks 'cperl-mode-hook)

;;; anything-setting.el ends here