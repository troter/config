
ELISP_DIR=dot.emacs.d/elisp
TMP_DIR=.tmp

EMACS=emacs
EMACS_BATCH_OPTION= --batch -no-init-file -no-site-file
EMACS_BATCH=$(EMACS) $(EMACS_BATCH_OPTION)

INSTALL_ELISP_EL=$(ELISP_DIR)/install-elisp.el
INSTALL_ELISP_EL_URL=http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el
YASNIPPET_URL=http://yasnippet.googlecode.com/files/yasnippet-0.5.9.tar.bz2

ELISP_URLS= http://stud4.tuwien.ac.at/~e0225855/linum/linum.el \
 http://tiny-tools.cvs.sourceforge.net/*checkout*/tiny-tools/tiny-tools/lisp/other/folding.el \
 http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el
EMACSWIKI_ELISP_NAME= auto-complete.el anything.el anything-config.el 

define install-elisp-base
	$(EMACS_BATCH) \
	--directory $(ELISP_DIR) \
	--load $(INSTALL_ELISP_EL) \
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

$(TMP_DIR):
	mkdir -p $(TMP_DIR)

$(ELISP_DIR):
	mkdir -p $(ELISP_DIR)

$(INSTALL_ELISP_EL): $(ELISP_DIR) 
	wget $(INSTALL_ELISP_EL_URL) --directory-prefix=$(ELISP_DIR)

update.install-elisp.el:
	$(call install-elisp-from-emacswiki, install-elisp.el)

yasnippet: $(TMP_DIR) $(ELISP_DIR)
	wget $(YASNIPPET_URL) --directory-prefix=$(TMP_DIR)
	( cd $(TMP_DIR); tar xjf $(notdir $(YASNIPPET_URL)) )
	cp $(TMP_DIR)/$(basename $(basename $(notdir $(YASNIPPET_URL))))/yasnippet.el $(ELISP_DIR)
	mkdir -p $(ELISP_DIR)/yasnippet
	cp -r $(TMP_DIR)/$(basename $(basename $(notdir $(YASNIPPET_URL))))/snippets $(ELISP_DIR)/yasnippet
	svn export -q --force http://svn.coderepos.org/share/config/yasnippet/common $(ELISP_DIR)/yasnippet/snippets

download: $(INSTALL_ELISP_EL) update.install-elisp.el yasnippet
	for url in $(EMACSWIKI_ELISP_NAME); \
	    do $(call install-elisp-from-emacswiki, "$$url"); \
	done
	for url in $(ELISP_URLS); \
	    do $(call install-elisp, "$$url"); \
	done

clean:
	rm -rf $(TMP_DIR)
	rm -rf $(ELISP_DIR)

all:
	echo "task is nothing"

install: install.dot.zshenv install.dot.zshrc install.dot.screenrc install.dot.inputrc install.dot.emacs.el install.dot.emacs.d

install.dot.zshenv:
	cp dot.zshenv $(HOME)/.zshenv

install.dot.zshrc:
	cp dot.zshrc $(HOME)/.zshrc

install.dot.screenrc:
	cp dot.screenrc $(HOME)/.screenrc

install.dot.inputrc:
	cp dot.inputrc $(HOME)/.inputrc

install.dot.emacs.el:
	cp dot.emacs.el $(HOME)/.emacs.el

install.dot.emacs.d: dot.emacs.d
	cp -R dot.emacs.d/ $(HOME)/.emacs.d
