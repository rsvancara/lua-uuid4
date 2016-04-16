CC=gcc
CFLAGS=-Wall -shared -fPIC
LDFLAGS=-I/usr/include/lua5.1 -L/usr/lib/x86_64-linux-gnu
all:
	$(CC)  $(CFLAGS) -o uuid.so uuid.c $(LDFLAGS) -llua5.1 -lcrypto -lm -Werror -DNDEBUG
clean:
	rm  *.so 
