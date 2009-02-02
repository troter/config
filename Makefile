
EMACS=emacs
EMACS_BATCH_OPTION= --batch -no-init-file -no-site-file
ELISP_DIR=dot.emacs.d/elisp
INSTALL_ELISP_EL=$(ELISP_DIR)/install-elisp.el
INSTALL_ELISP_EL_URL=http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el
ELISP_URLS= http://stud4.tuwien.ac.at/~e0225855/linum/linum.el 
EMACSWIKI_ELISP_NAME= auto-complete.el anything.el anything-config.el

# TODO: --eval を生成してまとめて評価するように変更した方がいいかも
#       anything.elとanything-config.elの絡みとか
define install-elisp-base
	$(EMACS) $(EMACS_BATCH_OPTION) --load $(INSTALL_ELISP_EL) \
	--eval "(setq install-elisp-confirm-flag nil)" \
	--eval "(setq install-elisp-repository-directory \"$(ELISP_DIR)\")" \
	--eval "($(strip $1) \"$(strip $2)\")"
endef

define install-elisp-from-emacswiki
	$(call install-elisp-base, install-elisp-from-emacswiki, $1)
endef

define install-elisp
	$(call install-elisp-base, install-elisp, $1)
endef

$(ELISP_DIR):
	mkdir -p $(ELISP_DIR)

$(INSTALL_ELISP_EL): $(ELISP_DIR) 
	wget $(INSTALL_ELISP_EL_URL) --directory-prefix=$(ELISP_DIR)

update.install-elisp.el:
	$(call install-elisp-from-emacswiki, install-elisp.el)

download: $(INSTALL_ELISP_EL) update.install-elisp.el
	for url in $(ELISP_URLS); \
            do $(call install-elisp, "$$url"); \
	done
	for url in $(EMACSWIKI_ELISP_NAME); \
	    do $(call install-elisp-from-emacswiki, "$$url"); \
	done

clean-download:
	rm -rf $(ELISP_DIR)

all:
	echo "task is nothing"

install: install.dot.zshenv install.dot.zshrc install.dot.screenrc install.dot.inputrc install.dot.emacs.el install.dot.emacs.d

install.dot.zshenv: dot.zshenv
	cp dot.zshenv $(HOME)/.zshenv

install.dot.zshrc: dot.zshrc
	cp dot.zshrc $(HOME)/.zshrc

install.dot.screenrc: dot.screenrc
	cp dot.screenrc $(HOME)/.screenrc

install.dot.inputrc: dot.inputrc
	cp dot.inputrc $(HOME)/.inputrc

install.dot.emacs.el: dot.emacs.el
	cp dot.emacs.el $(HOME)/.emacs.el

install.dot.emacs.d: dot.emacs.d
	cp -R dot.emacs.d/ $(HOME)/.emacs.d
