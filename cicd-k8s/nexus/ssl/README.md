export GODEBUG="x509ignoreCN=0"

keytool -printcert -sslserver ${NEXUS_DOMAIN}:${SSL_PORT} -rfc > /usr/local/share/ca-certificates/nexus.osc-devops.kr.crt
update-ca-certificates

ref : https://docs.docker.com/registry/insecure/#docker-still-complains-about-the-certificate-when-using-authentication


      openssl req \
        -nodes \
        -new \
        -keyout cakey.pem \
        -out cacert.csr \
        -subj "/C=CN/ST=Beijing/L=Beijing/O=UnitedStack/OU=Devops/CN=nexus.osc-devops.kr" \
        -config san.cnf

openssl x509 -extfile san.cnf -extensions req_ext -req -days 7000 -in cacert.csr -signkey cakey.pem -out cacert.pem -sha256

      openssl pkcs12 \
        -export \
        -in cacert.pem \
        -inkey cakey.pem \
        -out serverStore.p12 \
        -passout pass:password
        
    keytool  \
      -importkeystore \
      -noprompt \
      -deststorepass password \
      -destkeypass password \
      -destkeystore keystore.jks \
      -deststoretype PKCS12  \
      -srckeystore serverStore.p12 \
      -srcstoretype PKCS12 \
      -srcstorepass $PRIVATE_KEY_PASSWORD\


FATA[0000] pulling image: rpc error: code = Unknown desc = failed to pull and unpack image "nexus.osc-devops.kr:5000/cruse/echoserver:1.8": failed to resolve reference "nexus.osc-devops.kr:5000/cruse/echoserver:1.8": failed to do request: Head "https://nexus.osc-devops.kr:5000/v2/cruse/echoserver/manifests/1.8": x509: certificate signed by unknown authority 
➜  ssl git:(main) ✗ crictl pull nexus.osc-devops.kr:5000/cruse/echoserver:1.8
FATA[0000] pulling image: rpc error: code = Unknown desc = failed to pull and unpack image "nexus.osc-devops.kr:5000/cruse/echoserver:1.8": failed to resolve reference "nexus.osc-devops.kr:5000/cruse/echoserver:1.8": failed to do request: Head "https://nexus.osc-devops.kr:5000/v2/cruse/echoserver/manifests/1.8": x509: certificate signed by unknown authority 
