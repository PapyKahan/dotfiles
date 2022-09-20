cmd.exe /c "call `"C:\Program Files (x86)\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat`" && set > %temp%\vcvars.txt"

Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Content "env:\$($matches[1])" $matches[2]
  }
}

Remove-Item -Force "$env:temp\vcvars.txt"

$env:VIRTUAL_ENV_DISABLE_PROMPT = 'true'
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\default.omp.json" | Invoke-Expression
