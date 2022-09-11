FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get -q -y install \
    postfix \
    mailutils \
    libsasl2-2 \
    ca-certificates \
    libsasl2-modules && \
postconf -e smtpd_banner="\$myhostname ESMTP" && \
postconf -e relayhost=[smtp.gmail.com]:587 && \
postconf -e smtp_sasl_auth_enable=yes && \
postconf -e smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd && \
postconf -e smtp_sasl_security_options=noanonymous && \
postconf -e smtp_tls_CAfile=/etc/postfix/cacert.pem  && \
postconf -e smtp_use_tls=yes && \
sed -i '/^smtp_tls_CAfile =/d' /etc/postfix/main.cf && \

apt-get install -q -y \
    supervisor 
COPY supervisord.conf /etc/supervisor/
COPY init.sh /opt/init.sh

RUN rm -rf /var/lib/apt/lists/* /tmp/* && \
apt-get autoremove -y && \
apt-get autoclean

EXPOSE 25

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
