#!/bin/bash

# получаем дату истекания сертификата в массив:
str=`openssl x509 -enddate -noout -in ./net-24/pki/ca.crt`
cert_date=`echo $str | cut -c10-15,25-29`
expiration=$(date --date="${cert_date}" +'%m %d %Y')
expiration_date=($expiration)
echo certs_date = ${expiration_date[*]}

# получаем текущую дату в массив:
today=`date '+%m %d %Y'`
today_date=($today)
echo today_date = ${today_date[*]}

# заполнение массива разницей дат
for ((i=0; i<3; i++)); do 
    diff[i]=$(( ${expiration_date[i]} - ${today_date[i]} ))
done

# проверка срока действия сертификата:
# ...за день до истечения или просрочен в течении месяца
if [ ${diff[0]} -eq 0 ] && [ ${diff[1]} -le 1 ] && [ ${diff[2]} -eq 0 ] ; 
    then
        echo Expired tomorrow! Update certificates...
        rm -rf ./pki/ca.crt
        docker compose -f ./net-24/docker-compose.yaml up certs_openssl # УКАЖИ ПУТЬ
        ./installing_certs.sh

# ...если сертификат был выпущен 1го числа любого месяца
elif [ ${diff[0]} -eq 1 ] && [ ${diff[1]} -lt 0 ] && [ ${diff[2]} -eq 0 ] ;
    then
        echo Update certificates...
        rm -rf ./pki/ca.crt
        docker compose -f ./net-24/docker-compose.yaml up certs_openssl # УКАЖИ ПУТЬ
        ./installing_certs.sh

# ...если сертификат выпущен 1го января
elif [ ${diff[0]} -lt 0 ] && [ ${diff[1]} -lt 0 ] && [ ${diff[2]} -eq 1 ] ;
    then
        echo Update certificates...
        rm -rf ./pki/ca.crt
        docker compose -f ./net-24/docker-compose.yaml up certs_openssl # УКАЖИ ПУТЬ
        ./installing_certs.sh

else
    echo Certifiate is not expired!
fi

