# -*- coding:utf-8 -*-
.PHONY: all install clean clean-backup-file

all: install

install: clean-backup-file
	for file in `find . -name "dot.*" ! -name "dot.*.main"`; do \
	    dotfile=`echo $$file|cut -c  6-`; \
	    cp `pwd`/$$file $(HOME)/$$dotfile; \
	done

clean: clean-backup-file

clean-backup-file:
	for file in `find . -name *~`; do \
	    rm -rf $$file; \
	done

# end of Makefile
