all:
	echo "task is nothing"

install: install.dot.zshenv install.dot.zshrc

install.dot.zshenv: dot.zshenv
	cp dot.zshenv $(HOME)/.zshenv

install.dot.zshrc: dot.zshrc
	cp dot.zshrc $(HOME)/.zshrc
