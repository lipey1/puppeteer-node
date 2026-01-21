FROM node:20.9.0

# 1. Ativa o repositório 'contrib' e 'non-free' para permitir a instalação das fontes Microsoft
# 2. Aceita a licença da Microsoft (EULA) automaticamente via debconf
RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list \
    && apt-get update \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

RUN apt-get -y install --no-install-recommends \
  # --- Fontes Microsoft (Times New Roman, Arial, etc) ---
  ttf-mscorefonts-installer \
  # --- Fontes de compatibilidade (Calibri e outras) ---
  fonts-lyx \
  fonts-liberation \
  # --- Dependências que você já tinha ---
  ca-certificates \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgbm1 \
  libgcc1 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
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
  libxss1 \
  libxtst6 \
  lsb-release \
  wget \
  xdg-utils \
  # --- LibreOffice ---
  libreoffice \
  libreoffice-java-common \
  default-jre \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
  
RUN apt-get update \
     && apt-get install -y wget gnupg ca-certificates procps libxss1 \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-stable \
     && rm -rf /var/lib/apt/lists/* \
     && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh

# Atualiza o cache de fontes do sistema para garantir que o LibreOffice as veja
RUN fc-cache -f -v

ADD package.json /
