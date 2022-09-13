#!/bin/sh

if [ ! -z "${EMAIL}" ] && [ ! -z "${EMAILPASS}" ]; then
    echo "[smtp.gmail.com]:587    ${EMAIL}:${EMAILPASS}" > /etc/postfix/sasl_passwd
    postmap /etc/postfix/sasl_passwd
    rm /etc/postfix/sasl_passwd
    echo "postfix EMAIL/EMAILPASS combo is setup."
else
    echo "EMAIL or EMAILPASS not set!"
fi
unset EMAIL
unset EMAILPASS
