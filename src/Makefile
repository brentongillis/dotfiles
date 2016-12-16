CC=gcc
CFLAGS=-Wall -g

brightness: brightness.c
	$(CC) $(CFLAGS) -o brightness brightness.c

.PHONY: clean install
clean:
	rm brightness

install:
	sudo chown root:root brightness
	sudo chmod u+s brightness
	rm ~/.bin/brightness
	ln -s ~/GitHub/dotfiles/src/brightness ~/.bin/brightness
