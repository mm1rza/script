# Menu Pilihan
Write-Host "Pilih salah satu opsi berikut:"
Write-Host "1. Aktivasi Windows dan Office"
Write-Host "2. Install Spotify Anti-Iklan"
Write-Host "3. Download dan Ekstrak File mm1rza ke C:\#mirza"
$choice = Read-Host "Masukkan pilihan Anda (1/2/3):"

switch ($choice) {
    "1" {
        # Aktivasi Windows dan Office
        irm https://get.activated.win | iex
    }
    "2" {
        # Install Spotify Anti-Iklan
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify"
    }
    "3" {
        # Download dan Ekstrak File mm1rza ke C:\#mirza
        if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-Host "WARNING: This script is not running with administrator privileges." -ForegroundColor Red -BackgroundColor Black
            Write-Host "Please run PowerShell / CMD as Administrator and try again." -ForegroundColor Red -BackgroundColor Black
            Write-Host "" -ForegroundColor Red
            Write-Host "Jalankan ulang PowerShell / CMD sebagai Administrator." -ForegroundColor Green -BackgroundColor Black
            exit
        } else {
            $downloadUrl = "https://github.com/mm1rza/C-mirza/archive/refs/heads/main.zip"
            $localPath = "C:\#mirza"
            $zipFilePath = "C:\#mirza\C-mirza.zip"
            if (-Not (Test-Path $localPath)) {
                New-Item -ItemType Directory -Path $localPath -Force
            }
            Write-Output "Downloading file from $downloadUrl..."
            Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath
            Write-Output "Extracting file to $localPath..."
            Expand-Archive -Path $zipFilePath -DestinationPath $localPath -Force
            Write-Output "Cleaning up..."
            Remove-Item $zipFilePath
            Write-Output "Download and extraction complete."
            
            $sumber = "C:\#mirza\C-mirza-main"
            $tujuan = "C:\#mirza"
            if (-not (Test-Path -Path $tujuan)) {
                Write-Host "Folder tujuan tidak ada. Membuat folder tujuan..."
                New-Item -Path $tujuan -ItemType Directory
            } else {
                Write-Host "Folder tujuan sudah ada."
            }
            Write-Host "Memindahkan file dan folder dari $sumber ke $tujuan..."
            Get-ChildItem -Path $sumber -Recurse | ForEach-Object {
                $targetPath = Join-Path -Path $tujuan -ChildPath $_.FullName.Substring($sumber.Length)
                if ($_.PSIsContainer) {
                    if (-not (Test-Path -Path $targetPath)) {
                        Write-Host "Membuat folder: $targetPath"
                        New-Item -Path $targetPath -ItemType Directory
                    }
                } else {
                    Write-Host "Memindahkan file: $_.FullName ke $targetPath"
                    Move-Item -Path $_.FullName -Destination $targetPath -Force
                }
            }
            Write-Host "Menghapus folder sumber..."
            Remove-Item -Path $sumber -Recurse -Force
            Write-Host "Proses selesai."
        }
    }
    default {
        Write-Host "Pilihan tidak valid. Silakan coba lagi."
    }
}
