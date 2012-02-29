.PHONY: all pep8 pyflakes clean dev

GITIGNORES=$(shell cat .gitignore |tr "\\n" ",")

all: pep8

pep8: .gitignore
	pep8 . --exclude=$(GITIGNORES)

#TODO: setup pyflakes to run @splaice
pyflakes:
	@pyflakes .

dev: env env/.pip

env:
	virtualenv --no-site-packages env

env/.pip: env requirements.txt
	env/bin/pip -E env install -r requirements.txt
	env/bin/pip -E env install -e .
	touch env/.pip

test: env/.pip
	env/bin/testify tests

devclean:
	@rm -rf env

clean:
	@rm -rf build dist
