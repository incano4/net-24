#!/bin/sh

CA_CRT=/pki/ca.crt
CA_KEY=/pki/ca.key
WEB_CRT=/pki/web/webserver.crt
WEB_KEY=/pki/web/webserver.key


if [ -s "$CA_CRT" ] && [ -s "$CA_KEY" ] && [ -s "$WEB_CRT" ] && [ -s "$WEB_KEY" ] ; # -s = проверка на наличие файлов и наличия содержимого в них 
    then
        return 0;

    else # удалаяем старые файлы и генерируем новые
        rm -rf /pki/certs
        rm -rf /pki/db
        rm -rf /pki/ca*
        rm -rf /pki/se*
        rm -rf /pki/web/webserver*

        openssl genrsa -out ca.key ${PRIVATE_KEY_SIZE} &&
        openssl req -new -key ca.key -out ca.csr -config ./conf/ca_req.conf &&
        mkdir certs db && touch db/index && openssl rand -hex 16 > serial &&
        openssl ca -selfsign -in ca.csr -out ca.crt -config ./conf/ca.conf -batch &&
        openssl req -new -keyout ./web/webserver.key -out webserver.csr -nodes -config ./conf/webserver_req.conf &&
        openssl ca -in webserver.csr -out ./web/webserver.crt -config ./conf/ca.conf -batch
fi