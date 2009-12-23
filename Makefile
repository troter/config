# -*- coding:utf-8 -*-
.PHONY: all install clean clean-backup-file

all: install

install: clean-backup-file
	for file in dot.*; do \
            dotfile=`echo $$file|cut -c  4-`; \
	    ln -f -s `pwd`/$$file $(HOME)/$$dotfile; \
        done

clean: clean-backup-file

clean-backup-file:
	for file in `find . -name *~`; do \
	    rm -rf $$file; \
	done

# end of Makefile
