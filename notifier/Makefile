#gcc -o dialog `pkg-config --cflags --libs libnotify` dialog.c
TARGET=notify
CC=gcc
CFLAGS=-Wall -g `pkg-config --cflags --libs libnotify`

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c

.PHONY: clean install
clean:
	rm $(TARGET)

install:
	if [ -a ~/.bin/$(TARGET) ]; then rm ~/.bin/$(TARGET); fi;
	ln -s ~/GitHub/brentongillis/dotfiles/notifier/$(TARGET) ~/.bin/$(TARGET)
