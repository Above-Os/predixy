FROM n0madic/alpine-gcc:9.4.0 AS builder

WORKDIR /workspace
RUN apk add isl
RUN ln -s /usr/lib/libisl.so.15 /usr/lib/libisl.so.22
RUN git clone https://github.com/ronchaine/libexecinfo.git
RUN cd libexecinfo && make all && make install
RUN mkdir -p /workspace/src
COPY . /workspace/src/

RUN cd /workspace/src && make

FROM alpine:3.18
COPY --from=builder /workspace/src/src/predixy predixy
ENTRYPOINT [ "/predixy" ]