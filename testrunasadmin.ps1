# Cek apakah skrip dijalankan sebagai administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Membuka ulang PowerShell dengan hak administrator..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Script utama
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
