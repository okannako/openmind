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
# 📋 ÖN HAZIRLIK (5 dakika)
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}📋 ÖN HAZIRLIK BAŞLIYOR (5 dakika)${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Adım 1: Sistem Güncelleme
echo -e "${CYAN}[1/5] Sistem paket listesi güncelleniyor...${NC}"
sudo apt update -y > /dev/null 2>&1
echo -e "${GREEN}      ✓ Paket listesi güncellendi${NC}"
sleep 1

echo -e "${CYAN}[2/5] Sistem paketleri yükseltiliyor (bu biraz sürebilir)...${NC}"
sudo apt upgrade -y > /dev/null 2>&1
echo -e "${GREEN}      ✓ Sistem güncel${NC}"
sleep 1
echo ""

# Adım 2: Git ve Temel Araçlar
echo -e "${CYAN}[3/5] Git ve temel araçlar kuruluyor...${NC}"
sudo apt install -y git curl wget > /dev/null 2>&1
echo -e "${GREEN}      ✓ Git kuruldu: $(git --version | head -n1)${NC}"
sleep 1
echo ""

# Adım 3: Python ve Geliştirme Paketleri
echo -e "${CYAN}[4/5] Python geliştirme ortamı hazırlanıyor...${NC}"
sudo apt install -y python3-all-dev python3-pip build-essential > /dev/null 2>&1
echo -e "${GREEN}      ✓ Python: $(python3 --version)${NC}"
echo -e "${GREEN}      ✓ Pip: $(pip3 --version | cut -d' ' -f2)${NC}"
sleep 1
echo ""

# Adım 4: Ses ve Medya Paketleri
echo -e "${CYAN}[5/5] Ses ve medya kütüphaneleri kuruluyor...${NC}"
sudo apt install -y portaudio19-dev ffmpeg alsa-utils > /dev/null 2>&1
echo -e "${GREEN}      ✓ PortAudio kuruldu${NC}"
echo -e "${GREEN}      ✓ FFmpeg: $(ffmpeg -version 2>&1 | head -n1 | cut -d' ' -f3)${NC}"
echo -e "${GREEN}      ✓ ALSA utilities kuruldu${NC}"

echo ""
echo -e "${CYAN}[+] Virtual ses kartı modülü yükleniyor...${NC}"
sudo modprobe snd-dummy 2>/dev/null || echo -e "${YELLOW}      ⚠ Virtual ses kartı yüklenemedi (isteğe bağlı)${NC}"
echo -e "${GREEN}      ✓ Ses sistemi yapılandırıldı${NC}"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ ÖN HAZIRLIK TAMAMLANDI!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 2

# ================================================
# 🔧 UV PACKAGE MANAGER KURULUMU (2 dakika)
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}🔧 UV PACKAGE MANAGER KURULUMU (2 dakika)${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

echo -e "${CYAN}UV Python paket yöneticisi kuruluyor...${NC}"
sudo pip install uv --quiet
echo -e "${GREEN}✓ UV kuruldu: $(uv --version)${NC}"

if ! command -v uv &> /dev/null; then
    echo -e "${RED}❌ UV kurulamadı!${NC}"
    exit 1
fi

echo ""
sleep 2

# ================================================
# 📥 OM1 KURULUMU (5 dakika)
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${GREEN}📥 OM1 KURULUMU (5 dakika)${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

cd "$HOME"

if [ -d "OM1" ]; then
    echo -e "${YELLOW}⚠ Mevcut OM1 kurulumu bulundu, temizleniyor...${NC}"
    rm -rf OM1
    echo -e "${GREEN}✓ Temizlendi${NC}"
fi

echo -e "${CYAN}OM1 repository'si GitHub'dan indiriliyor...${NC}"
git clone https://github.com/OpenMind/OM1.git > /dev/null 2>&1
echo -e "${GREEN}✓ Repository indirildi${NC}"

cd OM1

echo -e "${CYAN}Alt modüller senkronize ediliyor...${NC}"
git submodule update --init > /dev/null 2>&1
echo -e "${GREEN}✓ Alt modüller hazır${NC}"

echo -e "${CYAN}Virtual environment oluşturuluyor...${NC}"
uv venv
if [ -f ".venv/bin/activate" ]; then
    echo -e "${GREEN}✓ Virtual environment hazır${NC}"
else
    echo -e "${RED}❌ Virtual environment oluşturulamadı!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ OM1 KURULUMU TAMAMLANDI!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
sleep 2

# ================================================
# 🔑 API KEY AYARLAMA
# ================================================
echo -e "${BLUE}================================================${NC}"
echo -e "${YELLOW}🔑 API KEY AYARLAMA${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""
echo -e "${CYAN}Portal Openmind sitesinden aldığınız api'yi girin:${NC}"
echo -e "${CYAN}👉 https://portal.openmind.org/${NC}"
echo ""
read -p "API Key: " API_KEY

if [ -z "$API_KEY" ]; then
    echo ""
    echo -e "${RED}❌ API key boş olamaz!${NC}"
    exit 1
fi

echo "OM_API_KEY=$API_KEY" > .env
echo ""
echo -e "${GREEN}✓ API key güvenli bir şekilde kaydedildi${NC}"
echo ""
sleep 2

# ================================================
# 🎉 KURULUM TAMAMLANDI - 10 SANİYE MESAJ
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
# 🚀 OTOMATİK BAŞLATMA
# ================================================
cd "$HOME/OM1"
source .venv/bin/activate
exec uv run src/run.py conversation
