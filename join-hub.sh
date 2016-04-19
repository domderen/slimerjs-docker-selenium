usr/bin/slimerjs -v
usr/bin/slimerjs --webdriver `hostname -I | awk '{print $1}'`:8080 ${PHANTOMJS_OPTS} --webdriver-selenium-grid-hub http://hub:4444 --webdriver-logfile /tmp/webdriver.log --webdriver-loglevel DEBUG
