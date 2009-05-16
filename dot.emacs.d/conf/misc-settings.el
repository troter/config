;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; misc-settings.el --- 

;; misc.
;; -----
(setq inhibit-startup-message t)
(auto-compression-mode t) ;;日本語infoの文字化け防止
(setq system-uses-terminfo nil)
(setq require-final-newline t)
;; (setq-default truncate-lines t)
;; (setq make-backup-files nil)                       ;バックアップファイルを作成しない
;; (setq kill-whole-line t)                           ;カーソルが行頭にある場合も行全体を削除

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; misc-settings.el ends here
