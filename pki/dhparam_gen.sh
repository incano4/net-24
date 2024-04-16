#!/bin/sh

DH_PARAM=/etc/nginx/https/ssl/dhparam.pem

if [ -s "$DH_PARAM" ] ; # -s = проверка на наличие файла и что он не пустой 
    then
        return 0;

    else
        openssl dhparam -out /etc/nginx/https/ssl/dhparam.pem ${DHPARAM_SIZE} 
fi