FROM themecloud/symfony

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install prerequisites
RUN apt-get update \
    && apt-get install -qqy --force-yes \
      bzip2 \
      git \
      openjdk-7-jre-headless \
      x11vnc \
      xvfb \
      xfonts-100dpi \
      xfonts-75dpi \
      xfonts-scalable \
      xfonts-cyrillic \
      wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Install browsers
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
  && echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list \
  && apt-get update -y \
  && apt-get install -qqy --force-yes \
    firefox \
    google-chrome-beta \
  && mkdir -p /usr/share/desktop-directories

# Create selenium user
RUN useradd -d /home/seleuser -m seleuser \
  && mkdir -p /home/seleuser/chrome \
  && chown -R seleuser /home/seleuser \
  && chgrp -R seleuser /home/seleuser

# Install NodeJS
ENV NVM_DIR /usr/local/nvm

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash \
  && . "$NVM_DIR/nvm.sh" \
  && nvm install node \
  && nvm use node

# Install Selenium and Phantomjs
RUN . "$NVM_DIR/nvm.sh" \
  && nvm use node \
  && npm install -gs \
    selenium-standalone@latest \
    phantomjs@latest \
  && selenium-standalone install

# Add selenium starting script
COPY entry_point.sh /usr/bin/selenium
RUN chmod +x /usr/bin/selenium

EXPOSE 4444 5999

CMD ["/opt/bin/entry_point.sh"]
