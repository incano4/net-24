# cd;
rm -rf pki;
mkdir pki && cd pki;
openssl genrsa -out ca.key 4096; #созд. закрытый ключ УЦ

# конф. файл для создания запроса на сертификат
cat <<EOF >ca_req.conf
[ req ]
default_bits = 4096
encrypt_key = no
default_md = sha256
prompt = no
utf8 = yes
distinguished_name = ca_distinguished_name
req_extensions = ca_extensions

[ ca_distinguished_name ]
C = RU
ST = Moscow State
L = Moscow
O = Bauman Moscow State Technical University
CN = Dychakovskaya Anastasia

[ ca_extensions ]
basicConstraints = critical,CA:TRUE
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
EOF

# созд. запроса на сертификат
openssl req -new -key ca.key -out ca.csr -config ca_req.conf;


echo "first = $USER";
export USR=incano
cat <<EOF >ca.conf
echo -e "second = $USR"
EOF

# # конф. файл УЦ
# cat <<EOF >ca.conf
# [ ca ]
# default_ca = ironman_ca

# [ ironman_ca ]
# home = ${ENV::HOME}/pki
# serial = $home/serial
# new_certs_dir = $home/certs
# database = $home/db/index
# certificate = $home/ca.crt
# private_key = $home/ca.key
# default_md = sha256
# default_days = 365
# policy = ca_policy
# copy_extensions = copyall
# x509_extensions = v3_ext

# [ ca_policy ]
# countryName = match
# stateOrProvinceName = supplied
# organizationName = supplied
# commonName = supplied
# organizationalUnitName = optional
# commonName = supplied

# [ v3_ext ]
# authorityKeyIdentifier = keyid,issuer
# EOF

# # служебные файлы
# mkdir certs db && touch db/index;
# openssl rand -hex 16 > serial;

# # генерация самоподписанного сертификата УЦ
# openssl ca -selfsign -in ca.csr -out ca.crt -config ca.conf;