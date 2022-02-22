#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/id_rsa \
    target/sweater-0.0.1-SNAPSHOT.jar \
    soloveid@172.27.104.149:/home/soloveid/

echo 'Restart server...'

ssh -tt -i ~/.ssh/id_rsa soloveid@172.27.104.149 << EOF
pgrep java | xargs kill -9
nohup java -jar sweater-0.0.1-SNAPSHOT.jar > log.txt &
EOF

echo 'Bye'

