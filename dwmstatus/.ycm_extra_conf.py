#CFLAGS=-Wall -Werror -Wpedantic -fomit-frame-pointer -fsanitize=address
def FlagsForFile(filename, **kwargs):
    return {
        'flags': [
            '-x',
            'c',
            '-Wall',
            '-Werror',
            '-pedantic',
            '-lX11',
        ],
    }
