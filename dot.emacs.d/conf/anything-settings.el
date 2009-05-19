;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; anything-setting.el ---

(when (require 'yasnippet nil t)
  (yas/initialize)
  ;; snippetsのディレクトリを指定
  (yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets/")
  (add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
  (add-to-list 'yas/extra-mode-hooks 'cperl-mode-hook)
)

;; (auto-install-batch "auto-complete development version")
(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (add-hook 'ruby-mode-hook
            (lambda ()
              (when (require 'rcodetools nil t)
                (require 'auto-complete-ruby)
                (make-local-variable 'ac-omni-completion-sources)
                (setq ac-omni-completion-sources
                      '(("\\.\\=" . (ac-source-rcodetools)))))))
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (require 'auto-complete-emacs-lisp)
                (make-local-variable 'ac-omni-completion-sources)
                (setq ac-omni-completion-sources
                      '(("\\.\\=" . (ac-source-emacs-lisp-features))))))
)

;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (require 'anything-config)
  (require 'anything-match-plugin)

  ;; (install-elisp-from-emacswiki "ac-anything.el")
  (require 'ac-anything)
  (define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)

  (when (featurep 'yasnippet)
    ;; (install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el")
    (require 'anything-c-yasnippet)
    (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
    (global-set-key (kbd "C-c y") 'anything-c-yas-complete))

  ;; candidates-file  plug-in
  (defun anything-compile-source--candidates-file (source)
    (if (assoc-default 'candidates-file source)
        `((init acf-init
                ,@(let ((orig-init (assoc-default 'init source)))
                    (cond ((null orig-init) nil)
                          ((functionp orig-init) (list orig-init))
                          (t orig-init))))
          (candidates-in-buffer)
          ,@source)
      source))
  (add-to-list 'anything-compile-source-functions 'anything-compile-source--candidates-file)

  (defun acf-init ()
    (destructuring-bind (file &optional updating)
        (anything-mklist (anything-attr 'candidates-file))
      (with-current-buffer (anything-candidate-buffer (find-file-noselect file))
        (when updating
          (buffer-disable-undo)
          (font-lock-mode -1)
          (auto-revert-mode 1)))))

  (defvar anything-c-source-home-directory
    '((name . "Home directory")
      ;; /log/home.filelist にホームディレクトリのファイル名が1行につきひとつ格納されている
      (candidates-file "/log/home.filelist" updating)
      (requires-pattern . 5)
      (candidate-number-limit . 20)
      (type . file)))

  (defvar anything-c-source-find-library
    '((name . "Elisp libraries")
      ;; これは全Emacs Lispファイル
      (candidates-file "/log/elisp.filelist" updating)
      (requires-pattern . 4)
      (type . file)
      (major-mode emacs-lisp-mode)))

  (setq anything-sources
        '(anything-c-source-buffers+
          anything-c-source-recentf
          anything-c-source-files-in-current-dir
;;          anything-c-source-home-directory
          anything-c-source-locate
          anything-c-source-buffer-not-found
          anything-c-source-colors
          anything-c-source-man-pages
          anything-c-source-emacs-commands
          anything-c-source-emacs-functions
          anything-c-source-calculation-result
          ))
)


;;; anything-setting.el ends here
