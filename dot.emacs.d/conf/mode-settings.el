;;; -*- coding: utf-8; indent-tabs-mode: nil -*-
;;; mode-setting.el ---

;; Emacs lisp
;; ----------
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (progn
               (setq indent-tabs-mode nil)
               )))

;; C/C++
;; -----
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

;; Ruby
;; ----
;; (require 'ruby-mode)
;; (require 'inf-ruby)
;; (require 'ruby-electric)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;; (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; (setq ruby-deep-indent-paren-style nil)
;; (setq ruby-electric-expand-delimiters-list '( ?\{))

;; (add-hook 'ruby-mode-hook
;;   '(lambda ()
;;      (progn
;;        (inf-ruby-keys)
;;        (ruby-electric-mode t)
;;        (define-key
;;  ruby-mode-map
;;  "\C-m"
;;  'ruby-reindent-then-newline-and-indent)
;;                 )))

;; ri emacs use fastri
;; gem install fastri
;; (setq ri-ruby-script "/home/takumi/bin/ri-emacs.rb")
;; (load "ri-ruby")

;; rd-mode
;; rd-mode included rdtool
;; (autoload 'rd-mode "rd-mode" "major mode for ruby document formatter RD" t)
;; (add-to-list 'auto-mode-alist '("\\.rd$" . rd-mode))

;;====================
;; prolog
;; (autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;; (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;; (autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
;; (setq prolog-system 'swi)  ; optional, the system you are using;
;;                            ; see `prolog-system' below for possible values
;; (setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
;;                                 ("\\.m$" . mercury-mode))
;;                                auto-mode-alist))

;;====================
;; parrot
;; include parrot
;; (load "parrot")
;; (autoload 'pir-mode "pir-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.pir\\'" . pir-mode))

;;====================
;; actionScript2
;; (autoload 'actionscript-mode "actionscript-mode" "actionscript" t)
;; (add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

;;====================
;; php
;; http://sourceforge.net/projects/php-mode/
;; (load-library "php-mode")
;; (require 'php-mode)
;; (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;;;============================================================
;;; other major modes 

;;====================
;; yasnipet
;; http://yasnippet.googlecode.com/files/yasnippet-bundle-0.4.5.el.tgz
;; http://yasnippet.googlecode.com/files/yasnippet-0.4.5.tar.bz2
;; (require 'yasnippet)
;; (yas/initialize)
;; (yas/load-directory "~/.elisp/snippets")

;;====================
;; migemo
;; (load "migemo")
;; (migemo-init)

;;====================
;; yaml
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;====================
;; twittering
;; http://lambdarepos.svnrepository.com/share/trac.cgi/browser/lang/elisp/twittering-mode/trunk/twittering-mode.el
;; (require 'twittering-mode)
;; (setq twittering-username "user")
;; (setq twittering-password "password")

;;====================
;; pukiwiki
;; http://www.bookshelf.jp/elc/pukiwiki-mode.el
;; http://tdiary.cvs.sourceforge.net/tdiary/contrib/util/tdiary-mode/
;; (setq pukiwiki-auto-insert t)
;; (autoload 'pukiwiki-edit "pukiwiki-mode" "pukwiki-mode." t)
;; (autoload 'pukiwiki-index "pukiwiki-mode" "pukwiki-mode." t)
;; (autoload 'pukiwiki-edit-url "pukiwiki-mode" "pukwiki-mode." t)
;; (setq pukiwiki-site-list
;;       '(("wiki name" "http://example.com/pukiwiki/index.php" nil utf-8-dos)))
;; 
;; (setq pukiwiki-save-post-data t)
;; 
;; http://raising-heart.blogspot.com/2006/10/pukiwiki-mode-for-pukiwiki-147.html
;; for pukiwiki 1.4 or later
;; (setq pukiwiki-fetch-index-regexp-1.4-later
;;       ;;"<li><a[^?]*\\?cmd=read&page=\\([^\"]*\\)\"[^>]*>\\([^<]*\\)</a>[<small>]*\\([^<]*\\)[</small>]*</li>"
;;       "<li><a[^?]*\\?\\([^\"]*\\)\">\\([^<]*\\)</a>[<small>]*\\([^<]*\\)[</small>]*</li>")


;;; mode-setting.el ends here
