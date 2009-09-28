# -*- coding:utf-8 -*-
# Makefile

.PHONY: all download install clean-download-file
all: install


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
