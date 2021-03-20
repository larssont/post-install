# Installation script for chocolatey

# Install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install packages
choco install javaruntime -fy
choco install ungoogled-chromium -fy
choco install firefox-beta -fy --pre
choco install vscode -fy --params "/NoDesktopIcon /NoAddContextMenuFiles"
choco install 7zip -fy
choco install gimp -fy
choco install discord -fy
choco install steam -fy
choco install anki -fy
choco install qbittorrent -fy
choco install openhardwaremonitor -fy
choco install audacity -fy
choco install vlc -fy --params "/Language:en"
choco install windirstat -fy
choco install bleachbit -fy
choco install etcher -fy
choco install firacode -fy
choco install microsoft-windows-terminal -fy
