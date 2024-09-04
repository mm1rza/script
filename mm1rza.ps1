# Menu Pilihan
Write-Host "Pilih salah satu opsi berikut:"
Write-Host "1. Aktivasi Windows dan Office"
Write-Host "2. Install Spotify Anti-Iklan"
Write-Host "3. Download dan Ekstrak File mm1rza ke C:\#mirza (PowerShell Windows)"
Write-Host "4. Download dan Ekstrak File mm1rza ke C:\#mirza (PowerShell 7)"
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
		Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"iex (iwr 'https://mnet.my.id/update/github/c' -UseBasicParsing)`"" -Verb RunAs
    }
	"4" {
        # Download dan Ekstrak File mm1rza ke C:\#mirza
		iex (iwr "https://mnet.my.id/update/github/c" -UseBasicParsing -AllowInsecureRedirect)
    }
    default {
        Write-Host "Pilihan tidak valid. Silakan coba lagi."
    }
}
