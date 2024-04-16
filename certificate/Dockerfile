FROM alpine:3.19.1

RUN apk add --upgrade apk-tools && \
    apk upgrade --available && \
    apk add --no-cache openssl

WORKDIR /pki
ENTRYPOINT ["sh"]