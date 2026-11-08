# install.ps1 - install qodercli-reverse on Windows
param(
  [string]$Version = "latest",
  [string]$InstallDir = "$env:LOCALAPPDATA\qodercli-reverse\bin"
)

$ErrorActionPreference = "Stop"
$Repo = "sham435/qodercli-reverse"

if ($Version -eq "latest") {
  $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$Repo/releases/latest"
  $Version = $release.tag_name
}

$Asset = "qodercli-reverse_windows_amd64.zip"
$Url = "https://github.com/$Repo/releases/download/$Version/$Asset"
$ChecksumsUrl = "https://github.com/$Repo/releases/download/$Version/SHA256SUMS"

$Tmp = New-TemporaryFile | ForEach-Object { Remove-Item $_; New-Item -ItemType Directory -Path $_ }
try {
  Invoke-WebRequest -Uri $Url -OutFile "$Tmp\$Asset"
  Invoke-WebRequest -Uri $ChecksumsUrl -OutFile "$Tmp\SHA256SUMS"
  # checksum verification
  $expected = (Select-String -Path "$Tmp\SHA256SUMS" -Pattern $Asset).Line.Split()[0]
  $actual = (Get-FileHash "$Tmp\$Asset" -Algorithm SHA256).Hash.ToLower()
  if ($expected -ne $actual) { throw "Checksum mismatch" }
  Expand-Archive -Path "$Tmp\$Asset" -DestinationPath $Tmp -Force
  New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
  Copy-Item "$Tmp\qodercli-reverse_windows_amd64.exe" "$InstallDir\qodercli-reverse.exe" -Force
  Write-Host "Installed to $InstallDir\qodercli-reverse.exe"
  Write-Host "Add $InstallDir to your PATH."
  & "$InstallDir\qodercli-reverse.exe" --version
} finally {
  Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue
}