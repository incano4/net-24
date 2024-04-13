FROM alpine:3.19.1

RUN apk add --upgrade apk-tools && \
    apk upgrade --available && \
    apk add openssl

WORKDIR /pki
CMD openssl genrsa -out ca.key 4096 && \
    openssl req -new -key ca.key -out ca.csr -config ca_req.conf && \
    mkdir certs db && \
    touch db/index && \
    openssl rand -hex 16 > serial && \
    openssl ca -selfsign -in ca.csr -out ca.crt -config ca.conf -batch
    #           -batch     Don't ask questions
    # ARG usr
# ENV usr=$usr
    # # && \