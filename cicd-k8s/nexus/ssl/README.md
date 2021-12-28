export GODEBUG="x509ignoreCN=0"

keytool -printcert -sslserver ${NEXUS_DOMAIN}:${SSL_PORT} -rfc > /usr/local/share/ca-certificates/nexus.osc-devops.kr.crt
update-ca-certificates
