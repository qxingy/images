FROM golang:1.18.0-alpine AS builder

ENV GOPROXY=https://goproxy.cn,https://goproxy.io,direct

RUN go install github.com/Dreamacro/clash@latest

FROM --from=builder $GOPATH/bin/clash /usr/bin/.

VOLUME /config
EXPOSE 7890

CMD clash -d /config