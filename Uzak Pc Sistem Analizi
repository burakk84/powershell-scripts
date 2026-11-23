Clear-Host
Write-Host "=== UZAK PC KAYNAK VE SISTEM ANALIZI ===" -ForegroundColor Cyan

# psexec.exe dosyasini once script klasorunde, yoksa sistem yolunda ara
$PsExecPath = if ($PSScriptRoot -and (Test-Path "$PSScriptRoot\psexec.exe")) { "$PSScriptRoot\psexec.exe" } else { "psexec" }

while ($true) {
    Write-Host "`n--------------------------------------------------"
    $TargetIP = Read-Host "Uzak bilgisayar IP veya Hostname girin (Cikis: 'exit')"
    if ($TargetIP -eq "exit" -or [string]::IsNullOrWhiteSpace($TargetIP)) { break }

    Write-Host "[WAIT] $TargetIP adresinden veriler cekiliyor..." -ForegroundColor Cyan

    $SingleLineCmd = "reg query `"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager`" /v Memory-Management-Parameters-NoExist 2>nul & typeperf `"\System\System Up Time`" -sc 1 & echo --- & dir C:\ | findstr /C:`"bytes free`" /C:`"bayt boş`" & echo --- & tasklist & echo --- & reg query `"HKLM\HARDWARE\Description\System\BIOS`" /v SystemProductName 2>nul & reg query `"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion`" /v ProductName 2>nul & reg query `"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion`" /v DisplayVersion 2>nul & echo --- & hostname & reg query `"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion`" /v CurrentBuild 2>nul & reg query `"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI`" /v LastLoggedOnUser 2>nul & reg query `"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending`" 2>nul && echo REBOOT_VAR & wmic bios get serialnumber /value 2>nul & wmic computersystem get totalphysicalmemory /value 2>nul & wmic os get freephysicalmemory /value 2>nul & wmic cpu get loadpercentage /value 2>nul"
    $RawOutput = & $PsExecPath \\$TargetIP -accepteula -s cmd /c "$SingleLineCmd" 2>$null

    if (-not $RawOutput -or ($RawOutput -join "") -notmatch "Time|K|dir|---") {
        Write-Host "[ERROR] $TargetIP baglanti hatasi! Cihaz kapali veya yetki sorunu var." -ForegroundColor Red
        continue
    }

    Write-Host "[SUCCESS] Veriler alindi:`n" -ForegroundColor Green
    $UptimeBlock, $DiskBlock, $ProcBlock, $SysBlock, $ExtraBlock = ($RawOutput -join "`r`n") -split "---"

    # Degiskenleri ayristir
    $PCModel  = if ($SysBlock -match "SystemProductName\s+REG_SZ\s+(.*)") { $Matches.Item(1).Trim() } else { "Bilinmiyor" }
    $OSName   = if ($SysBlock -match "ProductName\s+REG_SZ\s+(.*)") { $Matches.Item(1).Trim() } else { "Bilinmiyor" }
    $OSVer    = if ($SysBlock -match "DisplayVersion\s+REG_SZ\s+(.*)") { $Matches.Item(1).Trim() } else { "" }
    if ($ExtraBlock -and $ExtraBlock -match "CurrentBuild\s+REG_SZ\s+(\d+)" -and [int]$Matches.Item(1) -ge 22000) {
        $OSName = $OSName -replace "Windows 10", "Windows 11"
    }

    $HostName = if ($ExtraBlock) { ($ExtraBlock -split "`r?`n" | Where-Object { $_.Trim() -ne "" } | Select-Object -First 1).Trim() } else { "Bilinmiyor" }
    $LastUser = if ($ExtraBlock -match "LastLoggedOnUser\s+REG_SZ\s+(.*)") { $Matches.Item(1).Trim() } else { "Bilinmiyor" }
    $SerialNo = if ($ExtraBlock -match "SerialNumber=([^\r\n]+)") { $Matches.Item(1).Trim() } else { "Okunamadi" }
    $CpuLoad  = if ($ExtraBlock -match "LoadPercentage=(\d+)") { "%$($Matches.Item(1))" } else { "Okunamadi" }
    $TotRam   = if ($ExtraBlock -match "TotalPhysicalMemory=(\d+)") { [Math]::Round(([int64]$Matches.Item(1)) / 1GB, 1) } else { 0 }
    $FreeRam  = if ($ExtraBlock -match "FreePhysicalMemory=(\d+)") { [Math]::Round(([int64]$Matches.Item(1)) / 1MB, 2) } else { 0 }
    $RebootSt = if ($ExtraBlock -match "REBOOT_VAR") { "EVET (Bekleyen Restart Var!)" } else { "Hayir (Temiz)" }

    $UptimeStr = "Okunamadi"
    if ($UptimeBlock -match "`"([\d\.]+?)`"\r?\n" -or $UptimeBlock -match "\,([\d\.]+?)\r?\n") {
        $Sec = [double]$Matches.Item(1)
        if ($Sec -gt 0) { $UptimeStr = "{0} Gun, {1} Saat, {2} Dakika" -f [Math]::Floor($Sec/86400), [Math]::Floor(($Sec%86400)/3600), [Math]::Floor(($Sec%3600)/60) }
    }

    $FreeDiskStr = "Okunamadi"
    if ($DiskBlock -match "([\d\.,\s]+)\s+(bytes free|bayt boş)") {
        $FreeDiskGB = [Math]::Round(([int64]$Matches.Item(1).Replace(".","").Replace(",","").Replace(" ","").Trim()) / 1GB, 2)
        $FreeDiskStr = "$FreeDiskGB GB"
    }

    # TEK BLOKTA ALT ALTA CIKTI
    Write-Host "=== GENEL SISTEM VE KAYNAK OZETI ===" -ForegroundColor Yellow
    Write-Host "Hostname         : $HostName" -ForegroundColor Green
    Write-Host "Son Kullanici    : $LastUser" -ForegroundColor Green
    Write-Host "Bilgisayar Modeli: $PCModel" -ForegroundColor Green
    Write-Host "Seri Numarasi    : $SerialNo" -ForegroundColor Green
    Write-Host "Isletim Sistemi  : $OSName $OSVer" -ForegroundColor Green
    Write-Host "Acik Kalma Suresi: $UptimeStr" -ForegroundColor Green
    Write-Host "Anlik CPU Yuku   : $CpuLoad" -ForegroundColor Green
    if ($TotRam -gt 0) { Write-Host "RAM Durumu       : Bos $FreeRam GB / Toplam $TotRam GB" -ForegroundColor Green }
    Write-Host "C: Bos Alan      : $FreeDiskStr" -ForegroundColor Green
    Write-Host "Bekleyen Restart : $RebootSt" -ForegroundColor $(if ($RebootSt -match "EVET") { "Red" } else { "Green" })

    # SURECLER & TOP 5 RAM
    Write-Host "`n=== KRITIK SURECLER VE TOP 5 RAM ===" -ForegroundColor Yellow
    $Lines = $ProcBlock -split "`r`n"
    $Mc = $Lines | Select-String -Pattern "mc" -SimpleMatch | Select-Object -First 3
    $Wu = $Lines | Select-String -Pattern "wuau|trustedinstaller|tiworker"
    Write-Host "McAfee           : $(if ($Mc) { ($Mc -join ' | ').Trim() } else { 'Aktif surec yok' })" -ForegroundColor Gray
    Write-Host "Windows Update   : $(if ($Wu) { ($Wu -join ' | ').Trim() } else { 'Aktif yukleme yok' })" -ForegroundColor Gray

    $Procs = foreach ($Line in $Lines) {
        if ($Line -match "(.+?)\s+(\d+)\s+(Console|Services)\s+(\d+)\s+([\d\.,]+ K)") {
            [PSCustomObject]@{ Name = $Matches.Item(1).Trim(); MemMB = [Math]::Round(([int64]$Matches.Item(5).Replace(".","").Replace(",","").Replace(" K","").Trim()) / 1024, 1) }
        }
    }
    if ($Procs) {
        $Procs | Group-Object Name | ForEach-Object {
            [PSCustomObject]@{ Surec = $_.Name; Toplam_MB = [Math]::Round(($_.Group | Measure-Object MemMB -Sum).Sum, 1) }
        } | Sort-Object Toplam_MB -Descending | Select-Object -First 5 | Format-Table -AutoSize
    }
}
