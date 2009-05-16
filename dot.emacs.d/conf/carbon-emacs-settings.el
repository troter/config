;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; carbon-emacs-settings.el --- 

;; fullscreen.
;; -----------
(when (eq window-system 'mac)
  (add-hook 'window-setup-hook
            (lambda ()
              ;;              (setq mac-autohide-menubar-on-maximize t)
              (set-frame-parameter nil 'fullscreen 'fullboth)
              )))
(defun mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

(when (eq window-system 'mac)
  (global-set-key "\M-\r" 'mac-toggle-max-window))

;;; carbon-emacs-settings.el ends here
