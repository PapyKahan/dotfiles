$targetDir = "C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\"
if (!(Test-Path $targetDir)) {
    $targetDir = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\"
}

if (Test-Path $targetDir) {
    if (!(Test-Path "$env:temp\vcvars.txt")) {
        cmd.exe /c "call `"$targetDir\vcvars64.bat`" && set > %temp%\vcvars.txt"
    }
    Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            Set-Content "env:\$($matches[1])" $matches[2]
        }
    }
    Write-Host "Visual Studio environment variables loaded."
}

Invoke-Expression (&starship init powershell)

Set-Alias -Name activate -Value .\.venv\Scripts\activate
Function python_venv {python.exe -m venv .venv}
Set-Alias -Name py -Value python.exe

$env:PUPPETEER_SKIP_CHROMIUM_DOWNLOAD='true'
