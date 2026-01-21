FROM node:20.9.0

# 1. Configura repositórios e aceita licença da Microsoft
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    debconf-utils \
    && sed -i 's/Components: main/Components: main contrib non-free/g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

# 2. Instala Fontes (MS + Carlito para Calibri), LibreOffice e dependências
RUN apt-get install -y --no-install-recommends \
    ttf-mscorefonts-installer \
    fonts-liberation \
    fonts-lyx \
    # Fontes 'Carlito' e 'Caladea' são clones perfeitos da Calibri e Cambria
    fonts-crosextra-carlito \
    fonts-crosextra-caladea \
    libreoffice \
    libreoffice-java-common \
    default-jre \
    # Suas dependências de sistema (Chrome/Puppeteer)
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. Instalação do Chrome
RUN apt-get update \
     && apt-get install -y wget gnupg ca-certificates procps libxss1 \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-stable \
     && rm -rf /var/lib/apt/lists/* \
     && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh

# 4. CRUCIAL: Atualiza o cache do sistema e pré-inicializa o LibreOffice para indexar as fontes
RUN fc-cache -f -v && soffice --headless --terminate_after_init

ADD package.json /
