;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; language-settings.el --- 

;; language.
;; ---------
(set-language-environment "Japanese")
(defun setup-coding-system (language)
  (set-terminal-coding-system language)
  (set-keyboard-coding-system language)
  (set-buffer-file-coding-system language)
  (setq default-buffer-file-coding-system language)
  (prefer-coding-system language)
  (set-default-coding-systems language)
  (setq file-name-coding-system language))

(defun setup-language-environment-unix ()
  (if (equal (getenv "LANG") "ja_JP.EUC-JP")
      (setup-coding-system 'euc-jp)
    (setup-coding-system 'utf-8)))
(defun setup-language-environment-windows ()
  (setup-coding-system 'sjis))

(progn
  (if (< emacs-major-version 22)
      (require 'un-define))             ; mule-ucs
  (if (windows-ntp)
      (setup-language-environment-windows)
    (setup-language-environment-unix)))

;; 文脈依存な文字幅問題を解決
;; http://www.pqrs.org/tekezo/emacs/doc/wide-character/index.html
(utf-translate-cjk-set-unicode-range
 '((#x00a2 . #x00a3)                    ; ¢, £
   (#x00a7 . #x00a8)                    ; §, ¨
   (#x00ac . #x00ac)                    ; ¬
   (#x00b0 . #x00b1)                    ; °, ±
   (#x00b4 . #x00b4)                    ; ´
   (#x00b6 . #x00b6)                    ; ¶
   (#x00d7 . #x00d7)                    ; ×
   (#X00f7 . #x00f7)                    ; ÷
   (#x0370 . #x03ff)                    ; Greek and Coptic
   (#x0400 . #x04FF)                    ; Cyrillic
   (#x2000 . #x206F)                    ; General Punctuation
   (#x2100 . #x214F)                    ; Letterlike Symbols
   (#x2190 . #x21FF)                    ; Arrows
   (#x2200 . #x22FF)                    ; Mathematical Operators
   (#x2300 . #x23FF)                    ; Miscellaneous Technical
   (#x2500 . #x257F)                    ; Box Drawing
   (#x25A0 . #x25FF)                    ; Geometric Shapes
   (#x2600 . #x26FF)                    ; Miscellaneous Symbols
   (#x2e80 . #xd7a3) (#xff00 . #xffef)))

;;; language-settings.el ends here
