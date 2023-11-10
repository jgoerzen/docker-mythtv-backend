FROM jgoerzen/debian-base-vnc:bookworm
MAINTAINER John Goerzen <jgoerzen@complete.org>
COPY setup/ /tmp/setup/
RUN /tmp/setup/setup.sh
# tightvncserver has qt keymap problems.  add tigervnc
# REMEMBER TO UPDATE THE GI WHEN UPDATING THE VERSION
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
      apt-get -y --no-install-recommends install "mythtv-backend=1:33.1+fixes20231004.git26e76a3949-dmo0+deb12u1" xmltv-util mythweb \
        tigervnc-standalone-server tigervnc-common && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /var/lib/apt/lists/*  /var/tmp/*
COPY scripts/ /usr/local/bin/
RUN /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/lib/mythtv/.mythtv/3rdParty && \
    cd /var/lib/mythtv/.mythtv/3rdParty && \
    unzip /tmp/setup/jwplayer.zip && \
    rm -fr /tmp/* && \
    chown -R mythtv:mythtv /var/lib/mythtv/.mythtv && \
    chmod 0755 /var/lib/mythtv/.mythtv /var/lib/mythtv/.mythtv/3rdParty && \
    if [ -f /usr/bin/ping ]; then chmod u+s /usr/bin/ping; fi && \
    chmod u+s /bin/ping
# Send log to syslog
RUN echo 'EXTRA_ARGS="--syslog local7 --verbose"' >> /etc/default/mythtv-backend

EXPOSE 6554 6543 6544 6549 5901
CMD ["/usr/local/bin/boot-debian-base"]

