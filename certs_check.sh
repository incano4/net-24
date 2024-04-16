#!/bin/bash

# array=(04 04 04) # пример записи массива вручную

# получаем дату истекания сертификата в массив:
str=`openssl x509 -enddate -noout -in /home/$USER/net-24/pki/ca.crt`
cert_date=`echo $str | cut -c10-15,25-29`
expiration=$(date --date="${cert_date}" +'%m %d %Y')
expiration_date=($expiration)
echo certs_date = ${expiration_date[*]}

# # получаем текущую дату в массив:
today=`date '+%m %d %Y'`
today_date=($today)
echo today_date = ${today_date[*]}

# заполнение массива разницей дат
for ((i=0; i<3; i++)); do 
    # diff[i]=($(( ${expiration_date[i]} - ${today_date[i]} )))
    diff[i]=$(( ${expiration_date[i]} - ${today_date[i]} ))
    # diff[i]=$(( $i+1 ))
    # echo $diff
    # expiration_date=($expiration)
    # if [$diff=1] && [$i=2] ;
    #     then
    #         
    #     fi
done

if [ ${diff[0]} -eq 1 ] && [ ${diff[1]} -eq 0 ] && [ ${diff[2]} -eq 0 ] ; 
    then
        rm -rf ./pki/ca.crt
        docker compose -f ./net-24/docker-compose.yaml up certs_openssl # УКАЖИ НОРМ ПУТЬ
        echo истекает!!!

elif [ ${diff[0]} -lt 0 ] && [ ${diff[1]} -eq 1 ] && [ ${diff[2]} -eq 0 ] ;
    then
        echo начало-конец месяца
        rm -rf ./pki/ca.crt
        docker compose -f ./net-24/docker-compose.yaml up certs_openssl # УКАЖИ НОРМ ПУТЬ

elif [ ${diff[0]} -lt 0 ] && [ ${diff[1]} -lt 0 ] && [ ${diff[2]} -eq 1 ] ;
    then
        echo начало-конец ГОДА
        rm -rf ./pki/ca.crt
        docker compose -f ./net-24/docker-compose.yaml up certs_openssl # УКАЖИ НОРМ ПУТЬ

else
    echo Certifiate is not expired!
fi
echo ${diff[*]}

