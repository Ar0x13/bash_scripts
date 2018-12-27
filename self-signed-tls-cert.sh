#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: self-cert.sh example.com # This will create a self-signed certificate and a key for example.com ( _.example.com.crt and _.example.com.key )"
  exit 1
else
  openssl req -new -newkey rsa:2048 -nodes -keyout _."$1".key -subj "/C=/ST=/L=/O=/CN=*.$1" -days 3650 -x509 -out _."$1".crt
fi
