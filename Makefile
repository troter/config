# -*- coding:utf-8 -*-
# Makefile

.PHONY: all download install clean-download-file
all: install

ELISP_DIR=dot.emacs.d/elisp
TMP_DIR=.tmp

EMACS=emacs
EMACS_BATCH_OPTION= --batch -no-init-file -no-site-file
EMACS_BATCH=$(EMACS) $(EMACS_BATCH_OPTION)

INSTALL_ELISP_EL=$(TMP_DIR)/install-elisp.el
INSTALL_ELISP_EL_URL=http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el

define install-elisp-base
	$(EMACS_BATCH) --directory $(ELISP_DIR) --load $(INSTALL_ELISP_EL) \
	--eval "(add-to-list 'load-path \"$(ELISP_DIR)\")" \
	--eval "(setq install-elisp-confirm-flag nil)" \
	--eval "(setq install-elisp-repository-directory \"$(ELISP_DIR)\")" \
	--eval "($(strip $1) $(strip $2))"
endef
define install-elisp-from-emacswiki
	$(call install-elisp-base, install-elisp-from-emacswiki, $1)
endef
define install-elisp
	$(call install-elisp-base, install-elisp, $1)
endef

define auto-install
	$(EMACS_BATCH) --directory $(ELISP_DIR) --load $(ELISP_DIR)/auto-install.el --load $(INSTALL_ELISP_EL) \
	--eval "(add-to-list 'load-path \"$(ELISP_DIR)\")" \
	--eval "(setq install-elisp-confirm-flag nil)" \
	--eval "(setq install-elisp-repository-directory \"$(ELISP_DIR)\")" \
	--eval "(setq auto-install-save-confirm nil)" \
	--eval "(setq auto-install-install-confirm nil)" \
	--eval "(auto-install-update-emacswiki-package-name nil)" \
	--eval "(auto-install-compatibility-setup)" \
	--eval "(auto-install-batch $(strip $1))"
endef

YASNIPPET_URL=http://yasnippet.googlecode.com/files/yasnippet-0.5.9.tar.bz2

define download-yasnippet
	wget $(YASNIPPET_URL) --directory-prefix=$(TMP_DIR); \
	( cd $(TMP_DIR); tar xjf $(notdir $(YASNIPPET_URL)) ); \
	cp $(TMP_DIR)/$(basename $(basename $(notdir $(YASNIPPET_URL))))/yasnippet.el $(ELISP_DIR); \
	mkdir -p $(ELISP_DIR)/yasnippet; \
	cp -r $(TMP_DIR)/$(basename $(basename $(notdir $(YASNIPPET_URL))))/snippets $(ELISP_DIR)/yasnippet; \
	svn export -q --force http://svn.coderepos.org/share/config/yasnippet/common $(ELISP_DIR)/yasnippet/snippets;
endef

$(TMP_DIR):
	mkdir -p $(TMP_DIR)

$(ELISP_DIR):
	mkdir -p $(ELISP_DIR)

install-elisp.el: $(TMP_DIR) 
	wget $(INSTALL_ELISP_EL_URL) --directory-prefix=$(TMP_DIR)

clean-download-file:
	rm -rf $(TMP_DIR)
	rm -rf $(ELISP_DIR)

download: clean-download-file install-elisp.el $(ELISP_DIR)
	for url in `grep --exclude="*~" "(install-elisp-from-emacswiki " dot.emacs.d/conf/* | awk '{print $$NF}' | cut -f 1 -d ')' | sort`; do \
	    $(call install-elisp-from-emacswiki, "$$url"); \
	done
	for url in `grep --exclude="*~" "(install-elisp " dot.emacs.d/conf/* | awk '{print $$NF}' | cut -f 1 -d ')' | sort`; do \
	    $(call install-elisp, "$$url"); \
	done
	$(call download-yasnippet)
	# TODO:
	#(auto-install-batch "anything")
	#(auto-install-batch "auto-complete development version")
	#http://tiny-tools.cvs.sourceforge.net/*checkout*/tiny-tools/tiny-tools/lisp/other/folding.el

t:
	for url in `grep --exclude="*~" "(auto-install-batch " dot.emacs.d/conf/* | awk '{print $$NF}' | cut -f 1 -d ')' | sort`; \
	    do echo "$$url"; \
	    $(call auto-install, "$$url"); \
	done


install:
	for file in `ls | grep dot. | grep -v "~"`; do \
	    dotfile=`echo $$file|cut -c  4-`; \
	    if [ -d $$file ] ; then \
	        mkdir -p $(HOME)/$$dotfile; \
	        for f in `ls $$file`; do \
	            cp -R $$file/$$f $(HOME)/$$dotfile/; \
	        done \
	    else \
	        cp -f $$file $(HOME)/$$dotfile; \
	    fi \
	done

clean: clean-download-file
	rm -rf *~

# end of Makefile
