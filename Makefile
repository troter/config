all:
	echo "task is nothing"

install: install.dot.zshenv install.dot.zshrc install.dot.screenrc install.dot.inputrc

install.dot.zshenv: dot.zshenv
	cp dot.zshenv $(HOME)/.zshenv

install.dot.zshrc: dot.zshrc
	cp dot.zshrc $(HOME)/.zshrc

install.dot.screenrc: dot.screenrc
	cp dot.screenrc $(HOME)/.screenrc

install.dot.inputrc: dot.inputrc
	cp dot.inputrc $(HOME)/.inputrc
