if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat") {
    cmd.exe /c "call `"C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat`" && set > %temp%\vcvars.txt"
    Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            Set-Content "env:\$($matches[1])" $matches[2]
        }
    }

    Remove-Item -Force "$env:temp\vcvars.txt"
}



$env:VIRTUAL_ENV_DISABLE_PROMPT = 'true'
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\default.omp.json" | Invoke-Expression

Set-Alias -Name activate -Value .\.venv\Scripts\activate
Function python_venv {python.exe -m venv .venv}
Set-Alias -Name Create-Python-VEnv -Value python_venv
Set-Alias -Name py -Value python.exe
