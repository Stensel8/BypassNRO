# Bypass NRO

Download and run the bypass script to skip OOBE.

From CMD (Shift+F10 during OOBE):


Shortest way via DNS domain:
```
powershell -Command "irm https://bypassnro.stensel.nl | iex"
```

Full command:
```
powershell -Command "New-Item -ItemType Directory -Path 'C:\Temp' -Force; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Stensel8/bypassnro/main/bypass.ps1' -OutFile 'C:\Temp\bypass.ps1'" && powershell -NoProfile -ExecutionPolicy Bypass -File C:\Temp\bypass.ps1
```

Full command from PowerShell:

```
New-Item -ItemType Directory -Path 'C:\Temp' -Force | Out-Null; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Stensel8/bypassnro/main/bypass.ps1' -OutFile 'C:\Temp\bypass.ps1'; & 'C:\Temp\bypass.ps1'
```

