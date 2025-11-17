# Bypass NRO

### Status of Bypass Methods (November 2025)

Since March 2025, Microsoft's `oobe\bypassnro` command has been removed from Windows 11 (24H2/25H2). Until October 2025, the alternative bypass `start ms-cxh:localonly` (and `start ms-cxh://setaddlocalonly`) worked, but this was blocked starting with Insider Build 26220.6772 (October 6, 2025) and only works on the current 25H2 stable branch.

The BypassNRO method in this project still works because it uses Sysprep with a custom unattend.xml. This approach remains functional for now, because unattend.xml is part of Windows' official enterprise deployment tools and cannot easily be blocked by Microsoft without breaking enterprise scenarios.

- **Removal of oobe\bypassnro:** March 2025
- **Blocking of ms-cxh:localonly:** October 6, 2025 (Insider build 26220.6772 and higher)
- **This tool still works via Sysprep + unattend.xml, supported for enterprise and advanced deployments.**


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


