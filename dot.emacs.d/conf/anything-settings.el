;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; anything-setting.el ---

(when (require 'yasnippet nil t)
  (yas/initialize)
  ;; snippetsのディレクトリを指定
  (yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets/")
  (add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
  (add-to-list 'yas/extra-mode-hooks 'cperl-mode-hook))

;; (install-elisp-from-emacswiki "auto-complete.el")
(when (require 'auto-complete)
  (global-auto-complete-mode t)
  ;; (install-elisp "http://www.cx4a.org/pub/auto-complete-ruby.el")
  (add-hook 'ruby-mode-hook
            (lambda ()
              (when (require 'rcodetools nil t)
                (require 'auto-complete-ruby)
                (make-local-variable 'ac-omni-completion-sources)
                (setq ac-omni-completion-sources
                      '(("\\.\\=" . (ac-source-rcodetools)))))))
  ;; (install-elisp "http://www.cx4a.org/pub/auto-complete-emacs-lisp.el")
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (require 'auto-complete-emacs-lisp)
                (make-local-variable 'ac-omni-completion-sources)
                (setq ac-omni-completion-sources
                      '(("\\.\\=" . (ac-source-emacs-lisp-features))))))
)

;; (auto-install-batch "anything.el")
(require 'anything)
(require 'anything-config)

;; (install-elisp-from-emacswiki "ac-anything.el")
(require 'ac-anything)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)

;; (install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el")
(when (featurep 'yasnippet)
  (require 'anything-c-yasnippet)
  (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
  (global-set-key (kbd "C-c y") 'anything-c-yas-complete))

(setq anything-sources
      '(anything-c-source-buffers+
	anything-c-source-colors
	anything-c-source-recentf
	anything-c-source-man-pages
	anything-c-source-emacs-commands
	anything-c-source-emacs-functions
	anything-c-source-files-in-current-dir
        anything-c-source-calculation-result
	))

;;; anything-setting.el ends here
