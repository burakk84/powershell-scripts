# sifre_lock_expire.ps1

## English

This interactive script queries Active Directory users in a continuous loop. It reports account status, failed password attempts, password and account expiration, and lockout status. If an account is locked, the script offers to unlock it after confirmation.

### Features

- Account status (enabled or disabled) and lockout status
- Failed password attempt count and most recent failed attempt
- Last password change, password expiration, and account expiration
- Optional account unlock after an explicit prompt

### Requirements

- Active Directory PowerShell module (RSAT-AD-PowerShell)
- Domain connectivity and permission to read the required user properties
- Permission to unlock accounts if you want to use the unlock action

### Usage

~~~powershell
cd C:/path/to/script
./sifre_lock_expire.ps1
~~~

Enter a user's sAMAccountName or other accepted AD identity when prompted. Enter exit to quit.

## Türkçe

Bu etkileşimli betik, Active Directory kullanıcılarını sürekli bir döngü içinde sorgular. Hesabın aktiflik ve kilit durumunu, hatalı parola denemelerini, parola ve hesap bitiş tarihlerini gösterir. Hesap kilitliyse açık onay alarak kilidi açmayı teklif eder.

### Özellikler

- Hesap durumu (etkin veya devre dışı) ve kilit durumu
- Hatalı parola deneme sayısı ve son hatalı deneme zamanı
- Son parola değişikliği, parola bitiş tarihi ve hesap bitiş tarihi
- Açık onaydan sonra isteğe bağlı hesap kilidi açma

### Gereksinimler

- Active Directory PowerShell modülü (RSAT-AD-PowerShell)
- Etki alanı bağlantısı ve gerekli kullanıcı özelliklerini okuma yetkisi
- Kilit açma işlemini kullanmak için hesap kilidini açma yetkisi

### Kullanım

~~~powershell
cd C:/betik/dizini
./sifre_lock_expire.ps1
~~~

İstendiğinde kullanıcının sAMAccountName değerini veya AD tarafından kabul edilen başka bir kimliğini girin. Çıkmak için exit yazın.
