# go-argon2

**Key features**

- base image: golang:alpine
- phc-winner-argon2-20190702 (libargon2) is compiled from source
- created symbolic links under /usr/lib to make tvdburgt/go-argon2 don't complain about can't finding argon2.h
- g++ and other dependencies are installed for source code compilation
- gcc is installed for tvdburgt/go-argon2
- a small go app is used for testing the installation and deleted afterwards
