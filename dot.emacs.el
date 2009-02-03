;;; -*- coding: utf-8 -*-
;;; My emacs.el.
;;; ============

;;;============================================================
;;; utilitys 

;; platform predicate
(defun windows-ntp () (eq system-type 'windows-nt))
(defun meadowp () (featurep 'meadow))
(defun carbon-emacsp () (featurep 'carbon-emacs-package))

;; string utility
(defun strings-join (strings &optional separator)
  (if (and separator strings)
      (let ((rs (list (car strings)))
	    (ss (cdr strings)))
	(while ss
	  (setq rs (cons (car ss) (cons separator rs)))
	  (setq ss (cdr ss)))
	(setq strings (reverse rs))))
  (apply 'concat strings))

;; load path
(defun add-load-path (path &optional afterp)
  (if (member path load-path)
      load-path
    (setq load-path
          (if afterp
              (append load-path (list path))
            (cons path load-path)))))


;;;============================================================
;;; load-path
(add-load-path (concat (getenv "HOME") "/.elisp"))
(add-load-path (concat (getenv "HOME") "/.site-lisp"))
(add-load-path (concat (getenv "HOME") "/.emacs.d/elisp"))
(add-load-path (concat (getenv "HOME") "/.emacs.d/vendor"))


;;;============================================================
;;; natural language
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
  (cond ((equal (getenv "LANG") "ja_JP.UTF-8")
         (setup-coding-system 'utf-8))
        ((equal (getenv "LANG") "ja_JP.EUC-JP")
         (setup-coding-system 'euc-jp))))
(defun setup-language-environment-windows ()
  (setup-coding-system 'sjis))

(progn
  (if (< emacs-major-version 22)
      (require 'un-define))
  (cond ((not (windows-ntp))
         (setup-language-environment-unix))
        (t
         (setup-language-environment-windows))))


;;;============================================================
;;; input method
(defun setup-input-method-ime ()
  (setq default-input-method "MW32-IME")
  (setq-default mw32-ime-mode-line-state-indicator "[--]")
  (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  (mw32-ime-initialize)

  (wrap-function-to-control-ime 'y-or-n-p nil nil)
  (wrap-function-to-control-ime 'yes-or-no-p nil nil)
  (wrap-function-to-control-ime 'universal-argument t nil)
  (wrap-function-to-control-ime 'read-string nil nil)
  (wrap-function-to-control-ime 'read-from-minibuffer nil nil)
  (wrap-function-to-control-ime 'read-key-sequence nil nil)
  (wrap-function-to-control-ime 'map-y-or-n-p nil nil)
  (wrap-function-to-control-ime 'read-passwd t t) ; don't work as we expect.

  (add-hook 'mw32-ime-on-hook
	    (function (lambda () (set-cursor-color "blue"))))
  (add-hook 'mw32-ime-off-hook
	    (function (lambda () (set-cursor-color "black"))))
  (add-hook 'minibuffer-setup-hook
  	    (function (lambda ()
  			(if (fep-get-mode)
			    (set-cursor-color "blue")
			  (set-cursor-color "black")))))
  )
(defun setup-input-method-anthy ()
  ;; Anthy
  ;;    CTRL-\で入力モード切替え
  (load-library "anthy")
  (setq default-input-method "japanese-anthy"))

(cond ((windows-ntp)
       (setup-input-method-ime))
      (t ; other systems
       (or (condition-case nil
               (setup-input-method-anthy)
             (file-error nil))
           default-input-method)))


;;;============================================================
;;; font
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
   (strings-join '("-mplus-*-mplus-r-normal--10-*-*-*-*-*-fontset-mplus_10r"
                   "ascii:-mplus-gothic-medium-r-normal--10-*-iso8859-1"
                   "japanese-jisx0208:-mplus-gothic-medium-r-normal--10-*-jisx0208.1990-0"
                   "katakana-jisx0201:-mplus-gothic-medium-r-normal--10-*-jisx0201.1976-0")
                 ","))
  (create-fontset-from-fontset-spec
   (strings-join '("-mplus-*-mplus-r-normal--12-*-*-*-*-*-fontset-mplus_10b"
                   "ascii:-mplus-gothic-bold-r-normal--10-*-iso8859-1"
                   "japanese-jisx0208:-mplus-gothic-bold-r-normal--10-*-jisx0208.1990-0"
                   "katakana-jisx0201:-mplus-gothic-bold-r-normal--10-*-jisx0201.1976-0")
                 ","))
  (create-fontset-from-fontset-spec
   (strings-join '("-mplus-*-mplus-r-normal--12-*-*-*-*-*-fontset-mplus_12r"
                   "ascii:-mplus-fxd-medium-r-semicondensed--12-*-iso8859-1"
                   "japanese-jisx0208:-mplus-gothic-medium-r-normal--12-*-jisx0208.1990-0"
                   "katakana-jisx0201:-mplus-gothic-medium-r-normal--12-*-jisx0201.1976-0")
                 ","))
  (create-fontset-from-fontset-spec
   (strings-join '("-mplus-*-mplus-r-normal--12-*-*-*-*-*-fontset-mplus_12b"
                   "ascii:-mplus-fxd-bold-r-semicondensed--12-*-iso8859-1"
                   "japanese-jisx0208:-mplus-gothic-bold-r-normal--12-*-jisx0208.1990-0"
                   "katakana-jisx0201:-mplus-gothic-bold-r-normal--12-*-jisx0201.1976-0")
                 ","))
  (set-default-font "fontset-mplus_12r"))

(cond ((windows-ntp)
       (setup-font-windows))
      (t
       (cond (window-system
	      t)
;	      (setup-font-others-window-system))
	     (t
	      (setup-font-others)))))


;;;============================================================
;;; frame
(defun setup-frame-windows ()
  (setq default-frame-alist
        (append (list 
                 ;;'(foreground-color . "black")
                 '(foreground-color . "white")
                 '(background-color . "black")
                 ;;'(background-color . "LemonChiffon")
                 ;;'(background-color . "gray")
                 '(border-color . "black")
                 '(mouse-color . "white")
                 '(cursor-color . "black")
                 ;;'(ime-font . "Nihongo-12") ; TrueType のみ
                 ;;'(font . "bdf-fontset")    ; BDF
                 ;'(font . "private-fontset"); TrueType
                 '(width . 80)
                 '(height . 38)
                 '(top . 100)
                 '(left . 100))
                default-frame-alist))
  (set-frame-parameter (selected-frame)  'alpha  80))

(cond ((windows-ntp)
       (setup-frame-windows))
      (t
;       (require 'color-theme)
;       (color-theme-midnight)
       ))


;;;============================================================
;;; misc

;; key
;(global-set-key "\C-z" 'undo)                       ;;UNDO
;(global-set-key "\C-h" 'backward-delete-char)      ;;Ctrl-Hでバックスペース

;; mouse 
(mouse-wheel-mode t)                                ;;ホイールマウス
(cond ((windows-ntp)
       ;; マウスカーソルを消す
       (setq w32-hide-mouse-on-key t)
       (setq w32-hide-mouse-timeout 5000)))

;; view
(global-font-lock-mode t)                           ;;文字の色つけ
(transient-mark-mode t)
(show-paren-mode t)
(setq visible-bell t)                               ;;警告音を消す

;; hl-line
(global-hl-line-mode t)
(setq hl-line-face 'underline)
(hl-line-mode 1)

;; mode line
(setq line-number-mode t)                           ;;カーソルのある行番号を表示
(setq column-number-mode t)                         ;;カーソルのある列番号を表示
(display-time)                                      ;;時計を表示

;; window
(set-scroll-bar-mode 'right)                        ;;スクロールバーを右に表示
(menu-bar-mode -1)                                  ;;メニューバーを消す
(tool-bar-mode -1)                                  ;;ツールバーを消す
(setq frame-title-format                            ;;フレームのタイトル指定
        (concat "%b - emacs@" system-name))

;; other
(setq inhibit-startup-message t)
(auto-compression-mode t)                           ;;日本語infoの文字化け防止
(setq system-uses-terminfo nil)
(setq require-final-newline t)
;(setq-default truncate-lines t)
;(setq make-backup-files nil)                       ;;バックアップファイルを作成しない
;(setq kill-whole-line t)                           ;;カーソルが行頭にある場合も行全体を削除


;;;============================================================
;;; buffer utility

;; protbuf
;; http://www.splode.com/~friedman/software/emacs-lisp/src/protbuf.el
;(require 'protbuf) 

;; Phenix Scratch Buffer
;; URI: http://www.bookshelf.jp/soft/meadow_29.html#SEC381
(defun my-make-scratch (&optional arg) 
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
	  ;; *scratch* バッファーで kill-buffer したら内容を消去すだけにする
	  (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))
(add-hook 'after-save-hook
	  ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))

;; Auto save buffers enhanced
;; http://coderepos.org/share/browser/lang/elisp/auto-save-buffers-enhanced/trunk/auto-save-buffers-enhanced.el
;(require 'auto-save-buffers-enhanced)
;(auto-save-buffers-enhanced-include-only-checkout-path t)
;(auto-save-buffers-enhanced t)

;; Meadow/Emacs memo
(iswitchb-mode 1)
(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

;;(defvar dired-directory nil)
(defadvice iswitchb-completions (after
                                 iswitchb-completions-with-file-name
                                 activate)
  "選択してるときにファイル名とかを出してみる。"
  (when iswitchb-matches
    (save-excursion
      (set-buffer (car iswitchb-matches))
      (setq ad-return-value
            (concat ad-return-value
                    "\n"
                    (cond ((buffer-file-name)
                           (concat "file: "
                                   (expand-file-name (buffer-file-name))))
                          ((eq major-mode 'dired-mode)
                           (concat "directory: "
                                   (expand-file-name dired-directory)))
                          (t
                           (concat "mode: " mode-name " Mode"))))))))


;;;============================================================
;;; dired
;(require 'wdired)
;(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; sorter.el
;; http://www.bookshelf.jp/elc/sorter.el
;(load "sorter.el")

;; today highlight
(defface my-face-f-2 '((t (:foreground "yellow"))) nil)
(defvar my-face-f-2 'my-face-f-2)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (concat (format-time-string "%Y-%m-%d" (current-time)) " [0-9]....") arg t))
(add-hook 'dired-mode-hook
	  '(lambda ()
	     (font-lock-add-keywords
	      major-mode
	      (list
	       '(my-dired-today-search . my-face-f-2)
	       ))))
;; ls -alh
(defadvice dired-sort-order
  (around dired-sort-order-h activate)
  (ad-set-arg 0 (concat (ad-get-arg 0) "h"))
  ad-do-it
  (setq dired-actual-switches
	(dired-replace-in-string "h" "" dired-actual-switches)))

;;; elscreen
(setq elscreen-prefix-key "\C-z")
(setq elscreen-display-tab nil)
(load "elscreen")
(add-hook 'term-mode-hook '(lambda ()
                             (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))
			     (define-key term-raw-map "\C-p" 'previous-line)
			     (define-key term-raw-map "\C-n" 'next-line)
			     (term-set-escape-char ?\C-x)))

(require 'yasnippet)
(require 'anything-c-yasnippet)
(setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
(global-set-key (kbd "C-c y") 'anything-c-yas-complete) ;C-c yで起動 (同時にお使いのマイナーモードとキーバインドがかぶるかもしれません)
(yas/initialize)
(yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets/") ;snippetsのディレクトリを指定
(add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
(add-to-list 'yas/extra-mode-hooks 'cperl-mode-hook)



;;;============================================================
;;; programming major modes

;;====================
;; shell
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;(if (and (not (windows-ntp))
;         (file-exists-p "/usr/bin/zsh"))
    ;;use zsh
;    (setq explicit-shell-file-name "/usr/bin/zsh"))

;; for cygwin
;(setq explicit-shell-file-name "zsh.exe")
;(setq shell-file-name "sh.exe")
;(setq shell-command-switch "-c")
;(modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan-unix))

;; argument-editing の設定
;(require 'mw32script)
;(mw32script-init)
;(setq exec-suffix-list '(".exe" ".sh" ".pl"))
;(setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.:()-")

;; cygwin-mount.el
;; http://www.emacswiki.org/cgi-bin/wiki/download/cygwin-mount.el
;(require 'cygwin-mount)
;(cygwin-mount-activate)

;;====================
;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (progn
	       (setq indent-tabs-mode nil)
	       )))

;;====================
;; C/C++
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (progn
	       (c-set-style "BSD")
	       (setq tab-width 4)
	       (setq c-basic-offset tab-width)
	       (setq indent-tabs-mode nil)
	       (hide-ifdef-mode 1)
	       (c-set-offset 'innamespace 0))))
(add-hook 'c++-mode-hook
	  '(lambda ()
	     (progn
	       (c-set-style "BSD")
	       (setq tab-width 4)
	       (setq c-basic-offset tab-width)
	       (setq indent-tabs-mode nil)
	       (hide-ifdef-mode 1)
	       (c-set-offset 'innamespace 0))))
;; 有効なdefineを設定(シンボル登録リストを設定)
(setq hide-ifdef-define-alist
      ;; 登録リスト名
      '((list-name-linux __TARGET__LINUX__ USE_USB USE_NETWORK DEBUG_TEST SAMPLE)
	(list-name-win   __TARGET__WIN__   MASTER)
	(list-name-mac   __TARGET__MAC__   MASTER)
	))
;; デフォルトのシンボル登録リストの設定
(add-hook 'hide-ifdef-mode-hook
	  '(lambda () (hide-ifdef-use-define-alist 'list-name-linux)))

;;====================
;; Ruby
;(require 'ruby-mode)
;(require 'inf-ruby)
;(require 'ruby-electric)
;(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
;(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;(setq ruby-deep-indent-paren-style nil)
;(setq ruby-electric-expand-delimiters-list '( ?\{))

;(add-hook 'ruby-mode-hook
;	  '(lambda ()
;	     (progn
;	       (inf-ruby-keys)
;	       (ruby-electric-mode t)
;	       (define-key
;		 ruby-mode-map
;		 "\C-m"
;		 'ruby-reindent-then-newline-and-indent)
;	       )))

;; ri emacs use fastri
;; gem install fastri
;(setq ri-ruby-script "/home/takumi/bin/ri-emacs.rb")
;(load "ri-ruby")

;; rd-mode
;; rd-mode included rdtool
;(autoload 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
;(add-to-list 'auto-mode-alist '("\\.rd$" . rd-mode))

;;====================
;; prolog
;(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
;(setq prolog-system 'swi)  ; optional, the system you are using;
;                           ; see `prolog-system' below for possible values
;; (setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
;;                                 ("\\.m$" . mercury-mode))
;;                                auto-mode-alist))

;;====================
;; parrot
;; include parrot
;(load "parrot")
;(autoload 'pir-mode "pir-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.pir\\'" . pir-mode))

;;====================
;; actionScript2
;(autoload 'actionscript-mode "actionscript-mode" "actionscript" t)
;(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

;;====================
;; php
;; http://sourceforge.net/projects/php-mode/
;(load-library "php-mode")
;(require 'php-mode)
;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;;;============================================================
;;; other major modes 

;;====================
;; yasnipet
;; http://yasnippet.googlecode.com/files/yasnippet-bundle-0.4.5.el.tgz
;; http://yasnippet.googlecode.com/files/yasnippet-0.4.5.tar.bz2
;(require 'yasnippet)
;(yas/initialize)
;(yas/load-directory "~/.elisp/snippets")

;;====================
;; migemo
;(load "migemo")
;(migemo-init)

;;====================
;; yaml
;(require 'yaml-mode)
;(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;====================
;; twittering
;; http://lambdarepos.svnrepository.com/share/trac.cgi/browser/lang/elisp/twittering-mode/trunk/twittering-mode.el
;(require 'twittering-mode)
;(setq twittering-username "user")
;(setq twittering-password "password")

;;====================
;; pukiwiki
;; http://www.bookshelf.jp/elc/pukiwiki-mode.el
;; http://tdiary.cvs.sourceforge.net/tdiary/contrib/util/tdiary-mode/
;(setq pukiwiki-auto-insert t)
;(autoload 'pukiwiki-edit "pukiwiki-mode" "pukwiki-mode." t)
;(autoload 'pukiwiki-index "pukiwiki-mode" "pukwiki-mode." t)
;(autoload 'pukiwiki-edit-url "pukiwiki-mode" "pukwiki-mode." t)
;(setq pukiwiki-site-list
;      '(("wiki name" "http://example.com/pukiwiki/index.php" nil utf-8-dos)))
;
;(setq pukiwiki-save-post-data t)
;
;; http://raising-heart.blogspot.com/2006/10/pukiwiki-mode-for-pukiwiki-147.html
;; for pukiwiki 1.4 or later
;(setq pukiwiki-fetch-index-regexp-1.4-later
;      ;;"<li><a[^?]*\\?cmd=read&page=\\([^\"]*\\)\"[^>]*>\\([^<]*\\)</a>[<small>]*\\([^<]*\\)[</small>]*</li>"
;      "<li><a[^?]*\\?\\([^\"]*\\)\">\\([^<]*\\)</a>[<small>]*\\([^<]*\\)[</small>]*</li>")

;;; End of .emacs.el
