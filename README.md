# Bypass NRO

Download and run the bypass script to skip OOBE.

From CMD (Shift+F10 during OOBE):

```
powershell -Command "New-Item -ItemType Directory -Path 'C:\Temp' -Force; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Stensel8/bypassnro/main/bypass.ps1' -OutFile 'C:\Temp\bypass.ps1'" && powershell -NoProfile -ExecutionPolicy Bypass -File C:\Temp\bypass.ps1
```

From PowerShell:

```
New-Item -ItemType Directory -Path 'C:\Temp' -Force | Out-Null; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Stensel8/bypassnro/main/bypass.ps1' -OutFile 'C:\Temp\bypass.ps1'; & 'C:\Temp\bypass.ps1'
```


