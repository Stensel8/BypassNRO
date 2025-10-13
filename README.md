Skip OOBE.

1. Open Shift+F10.

From the cmd window (easiest):

```
curl -L -o %TEMP%\bypass.ps1 https://raw.githubusercontent.com/Stensel8/bypassnro/main/bypass.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File %TEMP%\bypass.ps1
```

Or from PowerShell:

```
Set-ExecutionPolicy -Scope Process Bypass -Force
Invoke-WebRequest https://raw.githubusercontent.com/Stensel8/bypassnro/main/bypass.ps1 -OutFile $env:TEMP\bypass.ps1
& $env:TEMP\bypass.ps1
```

Downloads `unattend.xml` from this repo and runs Sysprep.


