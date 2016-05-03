FROM ubuntu:12.04

# Env
ENV SLIMERJS_VERSION_F 1.0.0-pre
ENV CASPERJS_VERSION_T master
ENV SLIMERJSLAUNCHER=/usr/bin/firefox


# Commands
RUN \
apt-get update && \
apt-get upgrade -y && \
apt-get install -y vim git wget xvfb libxrender-dev libasound2 libdbus-glib-1-2 libgtk2.0-0 zip bzip2 && \
mkdir -p /srv/var && \
wget -O /tmp/slimerjs-$SLIMERJS_VERSION_F.zip http://download.slimerjs.org/nightlies/latest-slimerjs-master/slimerjs-$SLIMERJS_VERSION_F.zip && \
unzip /tmp/slimerjs-$SLIMERJS_VERSION_F.zip -d /tmp && \
rm -f /tmp/slimerjs-$SLIMERJS_VERSION_F.zip && \
mv /tmp/slimerjs-$SLIMERJS_VERSION_F/ /srv/var/slimerjs && \
echo '#!/bin/bash\nxvfb-run /srv/var/slimerjs/slimerjs $*' > /srv/var/slimerjs/slimerjs.sh && \
chmod 755 /srv/var/slimerjs/slimerjs.sh && \
ln -s /srv/var/slimerjs/slimerjs.sh /usr/bin/slimerjs && \
wget -O /tmp/firefox-45.0.tar.bz2 http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/45.0/linux-x86_64/en-US/firefox-45.0.tar.bz2 && \
tar xvjf /tmp/firefox-45.0.tar.bz2 -C /tmp && \
rm -f /tmp/firefox-45.0.tar.bz2 && \
ls -lah /tmp && \
mv /tmp/firefox/ /srv/var/firefox && \
ln -s /srv/var/firefox/firefox /usr/bin/firefox && \
apt-get autoremove -y && \
apt-get clean all

ADD join-hub.sh /usr/local/bin/
ADD wait-for-it.sh ./

RUN chmod +x ./wait-for-it.sh
RUN chmod +x /usr/local/bin/join-hub.sh

ENTRYPOINT ["sh", "-c", "./wait-for-it.sh hub:4444 -- /usr/local/bin/join-hub.sh"]
