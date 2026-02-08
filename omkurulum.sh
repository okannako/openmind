#!/bin/bash

# Renk değişkenleri (daha temiz kod)
WHITE='\033[0;37m'
CYAN='\e[36m'
NC='\e[0m' # No Color

# Banner fonksiyonu
show_banner() {
    echo -e "${WHITE}"
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
    echo " #####   ####        ####        ####  ####    ######    ##########  ####    ####  ###########   ####  ####";
    echo " ######  ####       ######       #### ####    ########   ##########  ####    ####  ####   ####   #### ####";
    echo " ####### ####      ###  ###      ########    ####  ####     ####     ####    ####  ####   ####   ########";   
    echo " #### #######     ##########     ########   ####    ####    ####     ####    ####  ###########   ########";
    echo " ####  ######    ############    #### ####   ####  ####     ####     ####    ####  ####  ####    #### ####";  
    echo " ####   #####   ####      ####   ####  ####   ########      ####     ############  ####   ####   ####  ####";
    echo " ####    ####  ####        ####  ####   ####    ####        ####     ############  ####    ####  ####   ####";
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
    echo -e "${CYAN}Twitter :${NC} https://x.com/NakoTurk"
    echo -e "${CYAN}Github  :${NC} https://github.com/okannako"
    echo -e "${CYAN}Youtube :${NC} https://www.youtube.com/@CryptoChainNakoTurk"
    echo -e "${NC}"
}

show_banner
sleep 3

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo "================================================"
echo "🚀 OM1 OTOMATIK KURULUM BAŞLIYOR"
echo "================================================"
echo ""

# ================================================
# 📋 ÖN HAZIRLIK - TEK SEFERDE TÜM PAKETLER
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}📋 SISTEM HAZIRLIĞI (3-5 dakika)${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

echo -e "${CYAN}Tüm sistem paketleri kuruluyor...${NC}"
echo -e "${YELLOW}(Bu işlem birkaç dakika sürebilir)${NC}"
echo ""

# TEK SEFERDE HEPSINI YÜK
sudo apt update -y && \
sudo apt install -y \
    git \
    curl \
    wget \
    python3-all-dev \
    python3-pip \
    build-essential \
    portaudio19-dev \
    ffmpeg \
    alsa-utils

echo ""
echo -e "${GREEN}✓ Git: $(git --version | head -n1)${NC}"
echo -e "${GREEN}✓ Python: $(python3 --version)${NC}"
echo -e "${GREEN}✓ Pip: $(pip3 --version | cut -d' ' -f2)${NC}"
echo -e "${GREEN}✓ FFmpeg: $(ffmpeg -version 2>&1 | head -n1 | cut -d' ' -f3)${NC}"
echo ""

echo -e "${CYAN}Virtual ses kartı modülü yükleniyor...${NC}"
sudo modprobe snd-dummy 2>/dev/null && echo -e "${GREEN}✓ Yüklendi${NC}" || echo -e "${YELLOW}⚠ Atlandı${NC}"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ SİSTEM HAZIR!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 2

# ================================================
# 🔧 UV KURULUMU
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}🔧 UV KURULUMU${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

echo -e "${CYAN}UV Python paket yöneticisi kuruluyor...${NC}"
sudo pip install uv --quiet
echo -e "${GREEN}✓ UV: $(uv --version)${NC}"

if ! command -v uv &> /dev/null; then
    echo -e "${RED}❌ UV kurulamadı!${NC}"
    exit 1
fi

echo ""
sleep 2

# ================================================
# 📥 OM1 KURULUMU
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}📥 OM1 KURULUMU${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

cd "$HOME"

if [ -d "OM1" ]; then
    echo -e "${YELLOW}⚠ Eski kurulum temizleniyor...${NC}"
    rm -rf OM1
    echo -e "${GREEN}✓ Temizlendi${NC}"
fi

echo -e "${CYAN}GitHub'dan indiriliyor...${NC}"
git clone https://github.com/OpenMind/OM1.git
echo -e "${GREEN}✓ İndirildi${NC}"
echo ""

cd OM1

echo -e "${CYAN}Alt modüller yükleniyor...${NC}"
git submodule update --init
echo -e "${GREEN}✓ Hazır${NC}"
echo ""

echo -e "${CYAN}Virtual environment oluşturuluyor...${NC}"
uv venv
if [ -f ".venv/bin/activate" ]; then
    echo -e "${GREEN}✓ Oluşturuldu${NC}"
else
    echo -e "${RED}❌ Hata!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ OM1 KURULDU!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 2

# ================================================
# 🔑 API KEY
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${YELLOW}🔑 API KEY${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""
echo -e "${CYAN}Portal: https://portal.openmind.org/${NC}"
echo ""
read -p "API Key: " API_KEY

if [ -z "$API_KEY" ]; then
    echo -e "${RED}❌ Boş olamaz!${NC}"
    exit 1
fi

echo "OM_API_KEY=$API_KEY" > .env
echo -e "${GREEN}✓ Kaydedildi${NC}"
echo ""
sleep 2

# ================================================
# 🎉 TAMAMLANDI
# ================================================
clear
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}              🎉 KURULUM TAMAMLANDI! 🎉${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${YELLOW}╔════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║                                                ║${NC}"
echo -e "${YELLOW}║  Kurulum tamamlandı.                           ║${NC}"
echo -e "${YELLOW}║  Portaldan Omcu bakiyenizi ve grafikleri       ║${NC}"
echo -e "${YELLOW}║  kontrol edin.                                 ║${NC}"
echo -e "${YELLOW}║                                                ║${NC}"
echo -e "${YELLOW}║  Node çalışıyorsa Omcu bakiyenizin azalması    ║${NC}"
echo -e "${YELLOW}║  ve grafiklerin hareketlenmesi gerekiyor.      ║${NC}"
echo -e "${YELLOW}║                                                ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════╝${NC}"
echo ""

for i in {10..1}; do
    printf "\r${CYAN}⏳ Agent %2d saniye içinde başlatılacak...${NC}   " $i
    sleep 1
done

echo ""
echo ""
echo -e "${GREEN}🚀 Agent başlatılıyor...${NC}"
echo ""
sleep 1

# ================================================
# 🚀 BAŞLAT
# ================================================
cd "$HOME/OM1"
source .venv/bin/activate
exec uv run src/run.py conversation
