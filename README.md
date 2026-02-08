<p align="center">
  <a href="">
    <img alt="Hero" src="https://github.com/user-attachments/assets/f4b68571-9dbb-4a7b-b904-eab651685de4" width="75%" />
  </a>
</p>

# OPENMIND NODE KURULUM REHBERİ
- Kurulumla birlikte basit bir şekilde node'u hemen başlatabiliyoruyz. Ancak bununla alakalı daha önce birkaç şey yapmamız gerekiyor. Portal Opennmind sitesine (https://portal.openmind.org/) giriyoruz, mail ile kaydamızı yapıyoruz ve ücretsiz bir şekilde Api keyimizi alıyoruz. Daha sonra bir vps'e ihtiyacımız var. Yüksek özellik istemiyor. Kendime göre en uygununu özelliklerini aşağıya bıraktım.

## Tavsiye Edilen Sistem Gereksinimleri
- CPU: 4+ ÇEKİRDEK
- RAM: 4+ GB
- İşletim Sistemi: Linux (Ubuntu 22)

## Kurulum Adımları ve Kodları
- Aşağıdaki tek satır kodu vps'nizde başlattığınızda size sadece Api Key'nizi soracak bunun girişini kendiniz yaptıktan sonra bütün işlemleri script tamamlayacak. 
- Kurulum tamamlandıktan ve loglar akmaya başladıktan sonra izlemeniz gereken şey Omcu bakiyenizin azalması ve Portal sitesinde Dashboard kısmındaki grafiklerin hareketlenmesi gerekiyor.

```
apt install tmux
tmux new-session -t om
wget -q -O omkurulum.sh https://raw.githubusercontent.com/okannako/openmind/refs/heads/main/omkurulum.sh && chmod +x omkurulum.sh && sudo /bin/bash omkurulum.sh
```
- Tmux ekranında çıkmak için ctrl+b sonra da d tuşuna basıyoruz.``tmux ls`` tmux ekranlarını listeler. ``tmux attach -t tmuxekranıadı`` ile de tmux ekranına giriş yapabilirsiniz.
- Bundan sonra Omcu bakiyeniz bitene kadar çalışmaya devam edecek. Eğer omcu bakiyesi edinmek istiyorsanız ücretli planlara sahip olmanız gerekiyor. Bu konuda da son tercih sizin.

## Node Durdurma ve Tekrar Başlatma
- Node durdurmak için ``ctrl+c`` yapınca duruyor durmazsa birkaç defa basın. Başlatmak içinde aşağıdaki kodları giriyoruz.
```
cd
cd ~/OM1
source .venv/bin/activate
uv run src/run.py conversation
```
