FROM alpine:3.19.1
# FROM alpine:latest

RUN apk add --upgrade apk-tools && \
    apk upgrade --available && \
    apk add --no-cache openssl

WORKDIR /pki
ENTRYPOINT ["sh"]

    #           -batch     Don't ask questions
    # ARG usr
# ENV usr=$usr
    # # && \