FROM node:20.9.0

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/Components: main/Components: main contrib non-free non-free-firmware/g' /etc/apt/sources.list.d/debian.sources

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    fontconfig \
    fonts-liberation \
    fonts-dejavu \
    fonts-noto \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    ttf-mscorefonts-installer \
    libreoffice \
    libreoffice-calc \
    xvfb \
    cabextract \
    xfonts-utils \
    libasound2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libxss1 \
    libgtk-3-0 \
    libnss3 \
    libxshmfence1 \
    libxext6 \
    libx11-6 \
    libxtst6 \
    libxrender1 \
    libxcb1 \
    libxfixes3 \
    libxau6 \
    libxdmcp6 \
    libxinerama1 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgbm1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ---- instala Calibri real ----
RUN mkdir -p /usr/share/fonts/truetype/msttcorefonts \
    && cd /usr/share/fonts/truetype/msttcorefonts \
    && wget -q https://downloads.sourceforge.net/project/mscorefonts2/cabs/PowerPointViewer.exe \
    && cabextract PowerPointViewer.exe \
    && rm PowerPointViewer.exe

# Atualiza cache de fontes
RUN fc-cache -f -v
