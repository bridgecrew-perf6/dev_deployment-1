#!/usr/bin/env bash

PUBLIC_CERT=cacert.pem 
PUBLIC_CERT_SUBJ=/CN=*.osc-devops.kr
PRIVATE_KEY=cakey.pem 
PRIVATE_KEY_PASSWORD=password


echo openssl req -nodes -new -x509 -keyout $PRIVATE_KEY -out $PUBLIC_CERT -subj "${PUBLIC_CERT_SUBJ}"
openssl req -nodes -new -x509 -keyout $PRIVATE_KEY -out $PUBLIC_CERT -subj "${PUBLIC_CERT_SUBJ}"
echo openssl pkcs12 -export -in $PUBLIC_CERT -inkey $PRIVATE_KEY -out jetty.key -passout pass:$PRIVATE_KEY_PASSWORD
openssl pkcs12 -export -in $PUBLIC_CERT -inkey $PRIVATE_KEY -out jetty.key -passout pass:$PRIVATE_KEY_PASSWORD
echo keytool -importkeystore -noprompt -deststorepass $PRIVATE_KEY_PASSWORD -destkeypass $PRIVATE_KEY_PASSWORD -destkeystore keystore.jks -srckeystore jetty.key -srcstoretype PKCS12 -srcstorepass $PRIVATE_KEY_PASSWORD
keytool -importkeystore -noprompt -deststorepass $PRIVATE_KEY_PASSWORD -destkeypass $PRIVATE_KEY_PASSWORD -destkeystore keystore.jks -srckeystore jetty.key -srcstoretype PKCS12 -srcstorepass $PRIVATE_KEY_PASSWORD
