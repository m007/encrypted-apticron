#!/bin/bash -eu

OUTPUT_FILE="encrypted-output.gpg"

docker build -t apticron-test .
docker run --rm --name apticron-test -t apticron-test:latest bash -c "apticron && sleep 7 && sed -n '/.*BEGIN PGP MESSAGE.*/,/.*END PGP MESSAGE.*/p' /var/mail/mail" > $OUTPUT_FILE
gpg -d $OUTPUT_FILE
