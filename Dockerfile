FROM golang:alpine

# build-base is for gcc which tvdburgt/go-argon2 needs
RUN apk add build-base 

# commands are based on: github.com/abstractvector/argon2
RUN apk --no-cache add --virtual build-dependencies g++ make ca-certificates openssl &&\
    # Fetches the source code
    wget "https://github.com/P-H-C/phc-winner-argon2/archive/20190702.tar.gz" -O "/tmp/argon2.tar.gz" &&\
    # Untar it
    tar zxvf "/tmp/argon2.tar.gz" -C /tmp &&\
    rm "/tmp/argon2.tar.gz" &&\
    mkdir -p "/usr/src" &&\
    mv "/tmp/phc-winner-argon2-20190702" "/usr/src/argon2" &&\
    cd "/usr/src/argon2" &&\
    # make argon2 and install
    make &&\
    make bench &&\
    make test &&\
    make install &&\
    # make bench and install
    install bench "/usr/bin" &&\
    # free space from build dependencies
    apk del build-dependencies

# make creates library files under a subdirectory that go-argon2 doesn't aware of
RUN ln -s "/usr/lib/x86_64-linux-gnu/libargon2.a" "/usr/lib/libargon2.a" &&\
    ln -s "/usr/lib/x86_64-linux-gnu/libargon2.so" "/usr/lib/libargon2.so" &&\
    ln -s "/usr/lib/x86_64-linux-gnu/libargon2.so.1" "/usr/lib/libargon2.so.1"

# test if package works without error
WORKDIR /testApp
COPY ./helloWorldApp .
RUN go mod tidy && go run .
WORKDIR /home
RUN rm -rf /testApp

ENTRYPOINT [ "/bin/sh" ]