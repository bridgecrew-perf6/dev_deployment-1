openssl req \
-nodes \
-new \
-keyout cakey.pem \
-out cacert.csr \
-subj "/C=CN/ST=Beijing/L=Beijing/O=UnitedStack/OU=Devops/CN=nexus.osc-devops.kr" \
-config san.cnf

openssl x509 -extfile san.cnf 
-extensions req_ext 
-req 
-days 7000 
-in cacert.csr 
-signkey cakey.pem 
-out cacert.pem -sha256

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

키생성
https://blog.naver.com/techshare/222281195854

클라이언트에 키 등록 및 확인
https://blog.naver.com/PostView.nhn?blogId=noggame&logNo=222122166940&parentCategoryNo=&categoryNo=33&viewDate=&isShowPopularPosts=false&from=postView

ontainerd - crictl 명령어 관련 내용
https://blog.naver.com/PostView.nhn?blogId=noggame&logNo=222122166940&parentCategoryNo=&categoryNo=33&viewDate=&isShowPopularPosts=false&from=postView
