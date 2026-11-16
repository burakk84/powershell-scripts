# Yönetici yetkisi ve AD modülü kontrolü
if (!(Get-Module -ListAvailable ActiveDirectory)) {
    Write-Host "HATA: RSAT (Active Directory Modülü) yüklü değil!" -ForegroundColor Red
    Pause; exit
}
Clear-Host
Write-Host "================================================" -ForegroundColor Yellow
Write-Host "   DOMAIN KULLANICI DURUM VE KİLİT AÇMA PANELI  " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Yellow
Write-Host "Çıkmak için 'exit' yazın.`n"

while ($true) {
    $sicil = Read-Host "Sorgulanacak Sicil / Kullanıcı Adı"
    if ($sicil -eq "exit") { break }
    if ([string]::IsNullOrWhiteSpace($sicil)) { continue }

    try {
        # Genişletilmiş özellik listesi
        $props = @(
            "DisplayName", "Title", "Department", "Enabled",
            "PasswordExpired", "AccountExpirationDate", "LockedOut", 
            "PasswordLastSet", "msDS-UserPasswordExpiryTimeComputed",
            "BadPwdCount", "LastBadPasswordAttempt"
        )
        
        $user = Get-ADUser -Identity $sicil -Properties $props -ErrorAction Stop
        
        # Durum Kontrolleri
        $enabledStatus = if ($user.Enabled) { "Aktif (Enabled)" } else { "PASİF (Disabled) !!!" }
        $enabledColor  = if ($user.Enabled) { "Green" } else { "Red" }

        $lockStatus = if ($user.LockedOut) { "KİLİTLİ (Locked) !!!" } else { "Açık (Unlocked)" }
        $lockColor  = if ($user.LockedOut) { "Red" } else { "Green" }

        # Tarih Hesaplamaları (Gün.Ay.Yıl Saat:Dakika)
        $lastSet = if ($user.PasswordLastSet) { $user.PasswordLastSet.ToString("dd.MM.yyyy HH:mm") } else { "Hiç Değiştirilmemiş" }
        $lastBad = if ($user.LastBadPasswordAttempt) { $user.LastBadPasswordAttempt.ToString("dd.MM.yyyy HH:mm") } else { "Kayıt Yok" }

        # Şifre Bitiş ve Kalan Gün Hesabı
        $expiryTime = $user."msDS-UserPasswordExpiryTimeComputed"
        if ($expiryTime -and $expiryTime -ne [int64]::MaxValue -and $expiryTime -ne 0) {
            $expiryDate = [datetime]::FromFileTime($expiryTime)
            $daysLeft = ($expiryDate - (Get-Date)).Days
            $dayText = if ($daysLeft -lt 0) { "SÜRESİ DOLMUŞ!" } else { "Kalan: $daysLeft gün" }
            $passExpiry = "$($expiryDate.ToString('dd.MM.yyyy HH:mm')) ($dayText)"
        } else {
            $passExpiry = "Süresiz (Never Expires)"
        }

        $accountExpiry = if ($user.AccountExpirationDate) { $user.AccountExpirationDate.ToString("dd.MM.yyyy HH:mm") } else { "Sınırsız (Never)" }

        # Rapor Ekranı
        Write-Host "`n--- [ $($user.SamAccountName) ] DURUM RAPORU ---" -ForegroundColor Cyan
        Write-Host "Ad Soyad / Unvan  : $($user.DisplayName) ($($user.Title))"
        Write-Host "Departman         : $($user.Department)"
        Write-Host "Hesap Durumu      : " -NoNewline; Write-Host $enabledStatus -ForegroundColor $enabledColor
        Write-Host "Hesap Kilidi      : " -NoNewline; Write-Host $lockStatus -ForegroundColor $lockColor
        Write-Host "Hatalı Deneme     : $($user.BadPwdCount) kez (Son: $lastBad)"
        Write-Host "Son Şifre Değişim : $lastSet"
        Write-Host "Şifre Bitiş Tarihi: $passExpiry" -ForegroundColor Yellow
        Write-Host "Hesap Bitiş Tarihi: $accountExpiry" -ForegroundColor DarkCyan
        Write-Host "---------------------------------------"

        # Kilit Açma Aksiyonu
        if ($user.LockedOut) {
            $onay = Read-Host "Bu hesabın kilidini açmak istiyor musunuz? (E/H)"
            if ($onay -match "^[eEyY]$") {
                Unlock-ADAccount -Identity $user.SamAccountName
                Write-Host "BAŞARILI: $($user.SamAccountName) hesabının kilidi açıldı!`n" -ForegroundColor Green
            } else {
                Write-Host "İşlem iptal edildi.`n" -ForegroundColor Gray
            }
        } else {
            Write-Host ""
        }
    }
    catch {
        Write-Host "HATA: Kullanıcı bulunamadı veya yetki sorunu oluştu! ($($_.Exception.Message))`n" -ForegroundColor Red
    }
}
