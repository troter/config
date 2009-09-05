;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; look-and-feel-settings.el --- 

;; font
;; ----
(defun setup-font-windows ()
  (setq w32-use-w32-font-dialog nil)
  (setq scalable-fonts-allowed t)
  (setq w32-enable-synthesized-fonts t)
  (create-fontset-from-fontset-spec
   "-*-Courier New-normal-r-*-*-12-*-*-*-c-*-fontset-TTG12c,
 japanese-jisx0208:-*-ＭＳ ゴシック-*-*-*-*-*-*-*-*-*-*-jisx0208-sjis,
 latin-jisx0201:-*-ＭＳ ゴシック-*-*-*-*-*-*-*-*-*-*-jisx0208-sjis,
 katakana-jisx0201:-*-ＭＳ ゴシック-*-*-*-*-*-*-*-*-*-*-jisx0208-sjis,
 mule-unicode-e000-ffff:-*-ＭＳ ゴシック-*-*-*-*-*-*-*-*-*-*-iso10646-1" t)
  (setcdr (assoc 'font default-frame-alist) "fontset-default")
  (set-frame-font "fontset-default")
  )
(defun setup-font-others ())
(defun setup-font-others-window-system ()
  ;;(set-default-font "-*-fixed-medium-r-normal--14-*-*-*-*-*-*-*")
  ;;(set-default-font "-*-fixed-medium-r-normal--12-*-*-*-*-*-*-*")
  ;;(set-face-font 'default
  ;;               "-shinonome-gothic-medium-r-normal--14-*-*-*-*-*-*-*")
  ;;(set-face-font 'bold
  ;;               "-shinonome-gothic-bold-r-normal--14-*-*-*-*-*-*-*")
  ;;(set-face-font 'italic
  ;;               "-shinonome-gothic-medium-i-normal--14-*-*-*-*-*-*-*")
  ;;(set-face-font 'bold-italic
  ;;               "-shinonome-gothic-bold-i-normal--14-*-*-*-*-*-*-*")
  (create-fontset-from-fontset-spec
   (strings-join
    '("-mplus-*-mplus-r-normal--10-*-*-*-*-*-fontset-mplus_10r"
      "ascii:-mplus-gothic-medium-r-normal--10-*-iso8859-1"
      "japanese-jisx0208:-mplus-gothic-medium-r-normal--10-*-jisx0208.1990-0"
      "katakana-jisx0201:-mplus-gothic-medium-r-normal--10-*-jisx0201.1976-0")
    ","))
  (create-fontset-from-fontset-spec
   (strings-join
    '("-mplus-*-mplus-r-normal--12-*-*-*-*-*-fontset-mplus_10b"
      "ascii:-mplus-gothic-bold-r-normal--10-*-iso8859-1"
      "japanese-jisx0208:-mplus-gothic-bold-r-normal--10-*-jisx0208.1990-0"
      "katakana-jisx0201:-mplus-gothic-bold-r-normal--10-*-jisx0201.1976-0")
    ","))
  (create-fontset-from-fontset-spec
   (strings-join
    '("-mplus-*-mplus-r-normal--12-*-*-*-*-*-fontset-mplus_12r"
      "ascii:-mplus-fxd-medium-r-semicondensed--12-*-iso8859-1"
      "japanese-jisx0208:-mplus-gothic-medium-r-normal--12-*-jisx0208.1990-0"
      "katakana-jisx0201:-mplus-gothic-medium-r-normal--12-*-jisx0201.1976-0")
    ","))
  (create-fontset-from-fontset-spec
   (strings-join
    '("-mplus-*-mplus-r-normal--12-*-*-*-*-*-fontset-mplus_12b"
      "ascii:-mplus-fxd-bold-r-semicondensed--12-*-iso8859-1"
      "japanese-jisx0208:-mplus-gothic-bold-r-normal--12-*-jisx0208.1990-0"
      "katakana-jisx0201:-mplus-gothic-bold-r-normal--12-*-jisx0201.1976-0")
    ","))
  (set-default-font "fontset-mplus_12r"))

(cond (windows-p
       (setup-font-windows))
      (t
       (cond (window-system
              t)
                                        ;      (setup-font-others-window-system))
             (t
              (setup-font-others)))))

;;; Color settings.
;;; ---------------
(global-font-lock-mode t)               ; font lock !!

(defun default-frame-color-setting ()
  ;; 文字の色を設定します。
  (add-to-list 'default-frame-alist '(foreground-color . "gray10"))
  ;; 背景色を設定します。
  (add-to-list 'default-frame-alist '(background-color . "white"))
  ;; カーソルの色を設定します。
  (add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
  ;; マウスポインタの色を設定します。
  (add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
  ;; モードラインの文字の色を設定します。
  (set-face-foreground 'modeline "white")
  ;; モードラインの背景色を設定します。
  (set-face-background 'modeline "MediumPurple2")
  ;; 選択中のリージョンの色を設定します。
  (set-face-background 'region "LightSteelBlue1")
  ;; モードライン（アクティブでないバッファ）の文字色を設定します。
  (set-face-foreground 'mode-line-inactive "gray30")
  ;; モードライン（アクティブでないバッファ）の背景色を設定します。
  (set-face-background 'mode-line-inactive "gray85")
  )
(defun color-theme-settings ()
  (when (require 'color-theme nil t)
    (color-theme-initialize)
    (color-theme-arjen)))

(if window-system
    (progn
      (default-frame-color-setting)
      (color-theme-settings)
      (add-to-list 'default-frame-alist '(alpha . 85))
      (set-frame-parameter nil 'alpha '(85 50))
      ))

;;; hl-line
;;; -------
(global-hl-line-mode t)
(setq hl-line-face 'underline)
(hl-line-mode 1)

;;; mode line
;;; ---------
(setq line-number-mode t)   ;;カーソルのある行番号を表示
(setq column-number-mode t) ;;カーソルのある列番号を表示
(display-time)              ;;時計を表示

;;; window
;;; ------
(if window-system
    (progn
      (set-scroll-bar-mode 'right) ;;スクロールバーを右に表示
      (tool-bar-mode -1)           ;;ツールバーを消す
      ))
(menu-bar-mode -1)       ;;メニューバーを消す
(setq frame-title-format ;;フレームのタイトル指定
      (concat "%b - emacs@" system-name))

;;; mouse 
;;; -----
(mouse-wheel-mode t) ;;ホイールマウス
(when windows-p
  ;; マウスカーソルを消す
  (setq w32-hide-mouse-on-key t)
  (setq w32-hide-mouse-timeout 5000))

;;; misc
;;; ----
(transient-mark-mode t) ;; show mark region
(show-paren-mode t)
(setq visible-bell t) ;;警告音を消す

;;; look-and-feel-settings.el ends here
