;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; buffer-setting.el ---

;; (install-elisp-from-emacswiki "install-elisp.el")
(require 'install-elisp)
(setq install-elisp-repository-directory install-elisp-directory)
;; (install-elisp-from-emacswiki "auto-install.el")
(require 'auto-install)
(auto-install-update-emacswiki-package-name nil)
(auto-install-compatibility-setup)

;;; buffer-setting.el ends here
