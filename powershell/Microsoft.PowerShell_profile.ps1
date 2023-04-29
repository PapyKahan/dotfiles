Set-Alias -Name activate -Value .\.venv\Scripts\activate
Function python_venv {python.exe -m venv .venv}
Set-Alias -Name py -Value python.exe

Invoke-Expression (&starship init powershell)
