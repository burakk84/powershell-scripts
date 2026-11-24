# Pc_Analiz.ps1

## English

This interactive script uses PsExec to collect a system and resource summary from a remote Windows computer. Enter an IP address or hostname when prompted; enter exit to quit.

### What it reports

- Hostname, last logged-on user, computer model, serial number, and Windows version
- System uptime, CPU load, memory, C: free space, and pending restart status
- Matching McAfee and Windows Update processes, plus the five processes using the most memory

### Requirements

- Windows PowerShell
- PsExec available as psexec.exe in the script folder or on PATH
- Network access and an account with permission to run PsExec commands on the target computer

### Usage

~~~powershell
cd C:/path/to/script
./Pc_Analiz.ps1
~~~

Enter the target IP address or hostname at the prompt. Enter exit to close the script.

## Türkçe

Bu etkileşimli betik, PsExec kullanarak uzak bir Windows bilgisayarından sistem ve kaynak özeti toplar. İstendiğinde IP adresi veya bilgisayar adı girin; çıkmak için exit yazın.

### Gösterilen bilgiler

- Bilgisayar adı, son oturum açan kullanıcı, model, seri numarası ve Windows sürümü
- Çalışma süresi, CPU yükü, bellek, C: sürücüsündeki boş alan ve bekleyen yeniden başlatma durumu
- McAfee ve Windows Update ile eşleşen işlemler ve belleği en çok kullanan beş işlem

### Gereksinimler

- Windows PowerShell
- psexec.exe dosyasının betiğin bulunduğu klasörde veya PATH içinde olması
- Hedef bilgisayara ağ erişimi ve PsExec komutlarını çalıştırma yetkisi olan bir hesap

### Kullanım

~~~powershell
cd C:/betik/dizini
./Pc_Analiz.ps1
~~~

İstendiğinde hedef bilgisayarın IP adresini veya adını girin. Betikten çıkmak için exit yazın.
