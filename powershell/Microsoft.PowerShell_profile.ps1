$targetDir = "C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\"
if (!(Test-Path $targetDir)) {
    $targetDir = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\"
}

if (Test-Path $targetDir) {
    cmd /c "`"$targetDir\vcvars64.bat`"&set" |
    foreach {
      if ($_ -match "(.*?)=(.*)") {
        Set-Item -force -path "ENV:\$($matches[1])" -value "$($matches[2])"
      }
    }
}

Invoke-Expression (&starship init powershell)

Set-Alias -Name activate -Value .\.venv\Scripts\activate
Function python_venv {python.exe -m venv .venv}
Set-Alias -Name py -Value python.exe

$env:PUPPETEER_SKIP_CHROMIUM_DOWNLOAD='true'
