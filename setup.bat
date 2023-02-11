set dir="%~dp0"

mklink /d %HOMEPATH%\AppData\Local\nvim %dir%\nvim
mklink %HOMEPATH%\.curlrc %dir%\curl\.curlrc
mklink /d %HOMEPATH%\.config\wezterm %dir%\wezterm
