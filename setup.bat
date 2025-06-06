@echo off
REM Set the path to the directory containing the script
REM (not the script itself)
set SCRIPT_DIR=%~dp0

mklink /D "%USERPROFILE%\AppData\Local\nvim" "%SCRIPT_DIR%\nvim"
mklink /D "%USERPROFILE%\AppData\Roaming\alacritty" "%SCRIPT_DIR%\alacritty"
mklink /D "%USERPROFILE%\AppData\Local\rio" "%SCRIPT_DIR%\rio"
mklink /D "%USERPROFILE%\AppData\Roaming\nushell" "%SCRIPT_DIR%\nushell"
REM create .config directory if it doesn't exist with your current user not as an administrator
mklink /D "%USERPROFILE%\.config\wezterm" "%SCRIPT_DIR%\wezterm"
mklink /D "%USERPROFILE%\.config\zellij" "%SCRIPT_DIR%\zellij"
mklink /D "%USERPROFILE%\.config\mcphub" "%SCRIPT_DIR%\mcphub"
mklink  "%USERPROFILE%\.config\starship.toml" "%SCRIPT_DIR%\starship\starship.toml"
