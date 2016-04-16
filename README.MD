#LUA UUID4
This lua module provides C UUID4 implementation in C that can be called from lua by uuid().  There
are many UUID4 implementations written in pure lua.  This module addresses some of the problems
I have found with those implementations which includes:

1.  They use math.random function to generate psuedo randon numbers which is limited.
2.  They use os.time() function call which has only second granularity or /dev/urandom or /proc/sys/kernel/random/uuid to seed math.random()
    which is either slow or there is not enough entropy which results in collisions or duplicates if you are generating a lot of UUIDs,
    say for example with NGINX.

# Goals of this Project
The impetus for this project was to provide a fast UUID4 generator to embed into NGINX.  While there are modules that generate unique identifiers, 
if you are using NGINX Plus, then it is difficult to get your module included.  If you can compile NGINX from source then you are set.  However if you
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

# Using with Nginx

Somewhere in the "http" section of your nginx configuration add the following secion to load the module.  Remember that the module needs to 
reside somewhere where NGINX Lua can see it.  For me this was /usr/lib/x86_64-linux-gnu/lua/5.1/uuid.so.  You need to copy this
module there after the compilition. This is for Ubuntu Trusty.  Your linux distribution may be different.  

```nginx

map $host $uuid {
   default '';
}

init_by_lua '
    require "uuid"
';
```

NOTE: The map makes the UUID available to things like your logs

In your server section, add the folling:

```nginx
set_by_lua $uuid '
    if ngx.var.http_x_request_id == nil then
        return uuid()
    else
        return ngx.var.http_x_request_id
    end
'; 
```

Lastly, if you want to see the uuid in your logs, update your logs to include the $uuid variable:

```nginx

log_format mycustomformat '[$time_local] "$request" $status $request_length $bytes_sent $request_time $uuid';

```


# Credits
Karthik Velakur -> https://gist.github.com/kvelakur
(UUID4 implemenation in C)


