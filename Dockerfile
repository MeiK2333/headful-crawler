FROM node:13.8.0-buster

COPY ./sources.list /etc/apt/

RUN cd /tmp && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -  && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get update && \
    apt-get install -yq \
    ca-certificates \
    curl \
    dumb-init \
    ffmpeg \
    fontconfig \
    fonts-indic \
    fonts-liberation \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    fonts-thai-tlwg \
    gconf-service \
    google-chrome-stable \
    libappindicator1 \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libdbus-glib-1-2 \
    libegl1 \
    libenchant1c2a \
    libevent-2.1-6 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libgl1 \
    libgles2 \
    libglib2.0-0 \
    libgtk-3-0 \
    libgudev-1.0-0 \
    libhyphen0 \
    libnotify4 \
    libnspr4 \
    libnss3 \
    libopus0 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libsecret-1-0 \
    libstdc++6 \
    libvpx5 \
    libwebp6 \
    libwebpdemux2 \
    libwoff1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxslt1.1 \
    libxss1 \
    libxt6 \
    libxtst6 \
    locales \
    lsb-release \
    pdftk \
    unzip \
    wget \
    x11-apps \
    x11-xkb-utils \
    x11vnc \
    xdg-utils \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
    xvfb

RUN apt-get -qq clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app

WORKDIR /app

COPY ./package.json /app

RUN npm install -registry=https://registry.npm.taobao.org && \
    npm install -g ts-node typescript -registry=https://registry.npm.taobao.org

COPY ./src /app

COPY ./start.sh /app

CMD ["./start.sh"]
