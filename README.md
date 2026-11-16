## Script Details: `sifre_lock_expire.ps1`

This interactive script allows System Administrators and IT Teams to query Active Directory users in a continuous loop, check account status (Enabled/Disabled), view failed login attempts (`BadPwdCount`), check password expiration and account lockout status, and unlock locked accounts.

### Features
* Continuous interactive loop for rapid user queries
* Account status verification (Enabled / Disabled)
* Failed password attempt count (`BadPwdCount`) and lockout status check
* Password expiration date calculation
* Instant account unlock functionality

### Prerequisites
* **Active Directory PowerShell Module** (`RSAT-AD-PowerShell`) installed on the machine.
* Appropriate permissions to read user properties and unlock accounts in Active Directory.

### Usage
1. Open **PowerShell** as Administrator.
2. Navigate to the directory where you saved the script:
   ```powershell
   cd C:\(\path\to\script \%\%\)MAGIT_PARSER_PROTECT%%   ```
3. Run the script:
   ```powershell
   .\sifre_lock_expire.ps1
   ```
4. Follow the on-screen prompts to check user status or unlock accounts.

---

## Betik Detayları: `sifre_lock_expire.ps1`

Bu etkileşimli betik, Sistem Yöneticilerinin ve BT Ekiplerinin Active Directory kullanıcılarını sürekli bir döngü içinde sorgulamasına, hesap aktiflik durumunu (Enabled/Disabled) ve hatalı şifre giriş sayısını (`BadPwdCount`) görmesine, şifre geçerlilik sürelerini kontrol etmesine ve kilitli hesapları anında açmasına olanak tanır.

### Özellikler
* Hızlı kullanıcı sorgulamaları için kesintisiz etkileşimli döngü
* Hesap aktiflik durumu kontrolü (Enabled / Disabled)
* Hatalı şifre giriş sayısı (`BadPwdCount`) ve kilit durumu görüntüleme
* Şifre geçerlilik bitiş tarihi sorgulama
* Kilitlenen hesapların kilidini saniyeler içinde açma

### Gereksinimler
* Bilgisayarda **Active Directory PowerShell Modülü** (`RSAT-AD-PowerShell`) yüklü olmalıdır.
* Active Directory üzerinde kullanıcı özelliklerini okuma ve hesap kilidi açma yetkisine sahip bir hesap kullanılmalıdır.

### Kullanım
1. **PowerShell** uygulamasını Yönetici (Administrator) olarak çalıştırın.
2. Betiği kaydettiğiniz dizine gidin:
   ```powershell
   cd C:\betik\dizini
   ```
3. Betiği çalıştırın:
   ```powershell
   .\sifre_lock_expire.ps1
   ```
4. Kullanıcı durumunu sorgulamak veya hesap kilidini açmak için ekrandaki yönergeleri takip edin.
