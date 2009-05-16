;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; buffer-setting.el ---

;; (install-elisp "http://www.emacswiki.org/emacs/download/install-elisp.el")
;; (install-elisp-from-emacswiki "install-elisp")
(require 'install-elisp)
(setq install-elisp-repository-directory install-elisp-directory)
;; (install-elisp-from-emacswiki "auto-install")
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;;; buffer-setting.el ends here
