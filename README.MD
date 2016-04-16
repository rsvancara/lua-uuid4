#LUA UUID4
This lua module provides a C UUID4 implementation in C that can be called from lua by uuid().  There
are many UUID4 implementations written in pure lua.  This module addresses some of the problems
I have found with those implementations include:

1.  They use math.random function to generate psuedo randon numbers which is limited.
2.  They use os.time() function call which has only second granularity or /dev/urandom or /proc/sys/kernel/random/uuid to seed math.random()
    which is either slow or there is not enough entropy which results in collisions or duplicates if you are generating a lot of UUIDs,
    say for example with NGINX.

# Goals of this Project
The impetus for this project was to provide a fast UUID4 generator to embed into NGINX.  While there are modules that generate unique identifiers, 
if you are using NGINX Plus, then it is difficult to get your module included.  If you can compile from source then you are set.  However if you
can not and you are looking at one of the pure LUA implementations and you are concerned with performance, then this module is what you need.

# How to Use

```lua

require 'uuid'
print(uuid())

```

# How to compile
I have provided a simple "Makefile" that you can edit.  The big parts to edit is the LDFLAGS which must point to your 
LUA Headers and LUA Libraries.  NOTE!!! If you are using this with NGINX on Trusty, then you need to link this against
LUA 5.1.  The make file unedited should compile this module fine on Ubuntu Trusty.

## Dependencies
1.  lua
    
    apt-get install liblua5.1-0-dev

2.  openssl

    apt-get install libssl-dev 

3.  gcc

4.  make 


# Compiling and Testing
Simply type make and then copy the library to where you want it to live.  There is a test.lua file in 
this directory that generates a million UUIDs if you want to test it.  

lua test.lua

# Credits
Karthik Velakur -> https://gist.github.com/kvelakur
(UUID4 implemenation in C)


