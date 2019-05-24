TARGET=bright
CC=gcc
CFLAGS=-Wall -O2 -Wpedantic

$(TARGET): main.c
	$(CC) $(CFLAGS) -o $(TARGET) main.c

.PHONY: clean install uninstall
clean:
	rm $(TARGET)

install:
	@sudo chown root:root $(TARGET)
	@sudo chmod u+s $(TARGET)
	@if [[ -L ~/.bin/$(TARGET) ]]; then rm ~/.bin/$(TARGET); fi;
	@ln -s ~/github/brentongillis/dotfiles/brightness/$(TARGET) ~/.bin/$(TARGET)

uninstall:
	@if [[ -L ~/.bin/$(TARGET) ]]; then rm ~/.bin/$(TARGET); fi;
