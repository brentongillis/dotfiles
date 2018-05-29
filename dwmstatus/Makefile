TARGET=dwmstatus
CC=gcc
CFLAGS=-Wall -Werror -pedantic -fomit-frame-pointer -O2 -lX11

$(TARGET): main.c
	@$(CC) $(CFLAGS) main.c -o $(TARGET)

.phony: clean
clean:
	rm $(TARGET)
