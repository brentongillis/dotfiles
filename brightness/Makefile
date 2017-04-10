TARGET=bright
CC=gcc
CFLAGS=-Wall -g

$(TARGET): $(TARGET).c
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c

.PHONY: clean install
clean:
	rm $(TARGET)

install:
	sudo chown root:root $(TARGET)
	sudo chmod u+s $(TARGET)
	if [ -a ~/.bin/$(TARGET) ]; then rm ~/.bin/$(TARGET); fi;
	ln -s ~/GitHub/brentongillis/dotfiles/brightness/$(TARGET) ~/.bin/$(TARGET)
