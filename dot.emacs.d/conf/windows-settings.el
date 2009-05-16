;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; windows-setting.el ---

(if (windows-ntp)
    (progn

      ;; argument-editing の設定
      (require 'mw32script)
      (mw32script-init)
      (setq exec-suffix-list '(".exe" ".sh" ".pl"))
      (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.:()-")

      ;; cygwin-mount
      ;; (install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/cygwin-mount.el")
      (require 'cygwin-mount)
      (cygwin-mount-activate)

      ))

;;; windows-setting.el ends here
