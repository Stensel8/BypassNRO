# Bypass NRO

## Status of Bypass Methods (December 2025)

Since March 2025, Microsoft's `oobe\bypassnro` command has been removed from Windows 11 (24H2/25H2). Until October 2025, the alternative `start ms-cxh:localonly` (and `start ms-cxh://setaddlocalonly`) worked, but this was blocked starting with Insider Build 26220.6772 (October 6, 2025) and only works on the current 25H2 stable branch.

The **BypassNRO method in this project still works** because it uses Sysprep with a custom unattend.xml. This approach remains functional for now, because unattend.xml is part of Windows' official enterprise deployment tools and cannot easily be blocked by Microsoft without breaking enterprise scenarios.

**Timeline:**
- Removal of `oobe\bypassnro`: March 2025
- Blocking of `ms-cxh:localonly`: October 6, 2025 (Insider build 26220.6772 and higher)

## Download and Run (Shift+F10 during OOBE)

### PowerShell
```powershell
iex(irm bypassnro.stensel.nl)
```

### CMD Wrapper
```powershell
powershell -c "iex(irm bypassnro.stensel.nl)"
```