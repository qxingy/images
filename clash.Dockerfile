FROM golang:1.18.0-alpine AS builder

ARG GOPATH=/go
ENV GOPROXY=https://goproxy.cn,https://goproxy.io,direct

RUN go env -w GOPATH=${GOPATH} && \
    go install github.com/Dreamacro/clash@latest

FROM alpine:latest

ARG GOPATH=/go
COPY --from=builder ${GOPATH}/bin/clash /usr/bin/.

VOLUME /config
EXPOSE 7890

CMD clash -d /config
