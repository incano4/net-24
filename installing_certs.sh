#!/bin/bash

# Установка сертификатов (Debian/Ubuntu): 
    sudo cp pki/ca.crt /usr/local/share/ca-certificates/ca.crt
    sudo update-ca-certificates
# Проверка: 
    openssl verify /usr/local/share/ca-certificates/ca.crt