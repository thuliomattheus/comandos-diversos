#!/bin/sh

# Ver o fingerprint (sha256) de todos os certificados
keytool -list -keystore keystore.p12 -storepass 3d3nDr09b4=D

# Ver um certificado específico em um formato mais legível
keytool -list -keystore keystore.p12 -alias user60 -v -storepass 3d3nDr09b4=D

# Ver um certificado específico como base64
keytool -list -keystore keystore.p12 -alias user60 -rfc -storepass 3d3nDr09b4=D

# Ver a chave pública
keytool -list -keystore keystore.p12 -alias user60 -rfc -storepass 3d3nDr09b4=D | openssl x509 -pubkey -noout | openssl rsa -pubin -text
