FROM python:3.11-slim

# Install system dependencies, VNC, and Japanese fonts
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    git \
    xvfb \
    x11vnc \
    supervisor \
    xfce4 \
    xfce4-terminal \
    fonts-ipafont \
    fonts-ipaexfont \
    fonts-noto-cjk \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

# Install noVNC
RUN mkdir -p /usr/share/novnc && \
    git clone https://github.com/novnc/noVNC.git /usr/share/novnc && \
    git clone https://github.com/novnc/websockify /usr/share/novnc/utils/websockify && \
    ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Install playwright system dependencies
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxkbcommon0 \
    libatspi2.0-0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libxtst6 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install playwright browsers
RUN playwright install

# Set up VNC password
RUN mkdir ~/.vnc && x11vnc -storepasswd your_password ~/.vnc/passwd

# Copy application code and configuration
COPY . .
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports for noVNC and VNC
EXPOSE 6080 5900

# Set display environment variable
ENV DISPLAY=:0

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]