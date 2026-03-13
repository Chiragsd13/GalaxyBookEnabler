# Galaxy Book Enabler

> Enable Samsung Galaxy Book features on any Windows PC

[![Version](https://img.shields.io/badge/version-3.2.0-blue.svg)](https://github.com/Chiragsd13/GalaxyBookEnabler)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-7.0%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Windows 11](https://img.shields.io/badge/Windows-11-0078D4.svg?logo=windows11)](https://www.microsoft.com/windows/windows-11)
[![SSSE Support](https://img.shields.io/badge/SSSE-Integrated-purple.svg)](https://github.com/Chiragsd13/GalaxyBookEnabler)
[![CodeFactor](https://www.codefactor.io/repository/github/chiragsd13/galaxybookenabler/badge)](https://www.codefactor.io/repository/github/chiragsd13/galaxybookenabler)
![View Count](https://komarev.com/ghpvc/?username=Chiragsd13&repo=GalaxyBookEnabler&color=brightgreen)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/Chiragsd13/GalaxyBookEnabler/total)

## Overview

Galaxy Book Enabler spoofs your Windows PC as a Samsung Galaxy Book, unlocking access to Samsung's ecosystem apps like Quick Share, Multi Control, Samsung Notes, and more. The tool provides an intelligent installer with package filtering, hardware compatibility detection, diagnostic logging, and automated startup configuration.

> **See what's new:** [Changelog](CHANGELOG.md) | [Releases](https://github.com/Chiragsd13/GalaxyBookEnabler/releases)

## Features

- **24 Galaxy Book Models** - Choose from authentic hardware profiles across Galaxy Book6/5/4/3 and legacy families
- **New Galaxy Book6 2026 Profiles** - Includes Galaxy Book6 Ultra (`960UJH`), Galaxy Book6 Pro (`960XJG`), and Galaxy Book6 (`760VJG`) — all sourced from real hardware
- **AMD Ryzen Support** - Better guidance and profile recommendations for AMD systems
- **Hardware Compatibility Report** - Detects CPU, Wi-Fi, and Bluetooth platforms before install and shows a feature support summary
- **Vendor-ID-Based Detection** - Language-independent Wi-Fi and Bluetooth detection for more reliable compatibility checks
- **Samsung MultiPoint Support** - Connect Galaxy Buds to multiple devices seamlessly via Samsung Settings app
- **Auto-Elevation** - Automatically requests admin rights (supports gsudo and Windows 11 native sudo)
- **Diagnostic Logging** - Automatic log generation for troubleshooting (saved to `%TEMP%`, works even with one-line install)
- **Smart Package Selection** - Choose from Core, Recommended, Full Experience, or custom package combinations
- **Package Manager** - Install or uninstall entire profiles from existing installations with status tracking
- **System Support Engine (Advanced)** - Optional experimental feature for enhanced Samsung integration (Windows 11 only)
- **Automated Startup** - Registry spoof runs automatically on every boot
- **Multi Control Recovery Task** - Restarts Samsung services at startup (+5 min) with a 1-minute grace period to improve Multi Control/phone reconnection reliability
- **Professional Installer** - Clean, color-coded UI with progress tracking
- **Differential Install** - Skips already-installed packages for faster re-runs
- **Test Mode** - Simulate installation without making changes to your system
- **Version Management** - Update detection and migration support
- **Easy Uninstall** - One-command removal with cleanup
- **Advanced Reset & Repair** - Built-in tools to fix app issues, clear caches, and repair permissions
- **Nuke Mode** - Optional destructive uninstall to wipe all Samsung app data

## Requirements

### IMPORTANT: This script requires PowerShell 7.0 or later

Windows comes with PowerShell 5.1 by default, which is **NOT compatible**. You must install PowerShell 7:

```powershell
# Install PowerShell 7 (one-time setup)
winget install Microsoft.PowerShell
````

**Note:** If this is your first time using `winget`, you may need to run `winget list` first to accept the source agreements. The command may appear to stall without this step.

Or download from: [https://aka.ms/powershell](https://aka.ms/powershell)

After installing, use `pwsh` (PowerShell 7) instead of `powershell` (Windows PowerShell 5.1).

## Quick Start

### One-Line Install (from GitHub)

```powershell
# Run in PowerShell 7 (pwsh)
irm https://raw.githubusercontent.com/Chiragsd13/GalaxyBookEnabler/main/bootstrap.ps1 | iex
```

*The installer will automatically request administrator privileges if needed.*

### Uninstall Options

When running the installer on an existing installation, you have granular uninstall options:

* **Reinstall (nuke + fresh install)**: Completely removes everything (preserving BIOS config), then performs a clean installation
* **Uninstall everything**: Removes all Samsung apps, services, scheduled tasks, and configuration

  * **Nuke Mode**: Optionally delete ALL Samsung app data (caches, settings, databases) during uninstall
* **Uninstall apps only**: Removes all installed Samsung apps while keeping services and scheduled tasks
* **Uninstall services only**: Removes scheduled tasks and Samsung services while keeping apps installed

**With gsudo (recommended for seamless elevation):**

```powershell
# Install gsudo first (one-time)
winget install gerardog.gsudo

# Then install Galaxy Book Enabler with automatic elevation
irm https://raw.githubusercontent.com/Chiragsd13/GalaxyBookEnabler/main/Install-GalaxyBookEnabler.ps1 | gsudo pwsh
```

### Manual Install

1. Download `Install-GalaxyBookEnabler.ps1`
2. Run: `.\Install-GalaxyBookEnabler.ps1`
3. Accept UAC prompt when requested
4. Follow the interactive installer

Or use:

```powershell
iwr https://raw.githubusercontent.com/Chiragsd13/GalaxyBookEnabler/main/Install-GalaxyBookEnabler.ps1 -OutFile Install-GalaxyBookEnabler.ps1
pwsh .\Install-GalaxyBookEnabler.ps1
```

*No need to manually "Run as Administrator" - the script handles elevation automatically!*

### Uninstall

```powershell
.\Install-GalaxyBookEnabler.ps1 -Uninstall
```

### Test Mode (No Changes Applied)

```powershell
.\Install-GalaxyBookEnabler.ps1 -TestMode
```

Test mode simulates the entire installation without making any actual changes. Perfect for testing or reviewing what the installer will do before committing.

### Fully Autonomous Install (CI / Scripted)

Run the installer non-interactively with all options specified up front:

```powershell
.\Install-GalaxyBookEnabler.ps1 `
   -FullyAutonomous `
   -AutonomousModel 960XGL `
   -AutonomousPackageProfile Recommended `
   -AutonomousInstallSsse:$true `
   -AutonomousSsseStrategy Dual `
   -AutonomousConfirmPackages:$true `
   -AutonomousCreateAiSelectShortcut:$false `
   -DebugOutput `
   -LogDirectory "C:\GalaxyBook\Logs"
```

Notes:

* `-AutonomousPackageProfile` supports: `Core`, `Recommended`, `RecommendedPlus`, `Full`, `Everything`, `Custom`, `Skip`
* For `Custom`, pass `-AutonomousPackageNames` with package names/IDs
* `-AutonomousModel` must match a model code from the model list (e.g. `960XGL`, `960XGK`, `960XKA`)
* `-AutonomousAction` supports: `Install` (default), `UpdateSettings`, `UpgradeSSE`, `UninstallAll`, `Cancel`
* Logs default to `C:\GalaxyBook\Logs` in autonomous mode unless `-LogPath` or `-LogDirectory` is supplied

## Reset & Repair Tools

The installer includes a comprehensive suite of tools to fix common issues with Samsung apps. Select **"Reset/Repair Samsung Apps"** from the main menu (or uninstall menu) to access:

* **Diagnostics**: Checks installed packages, device data files, and databases
* **Soft Reset**: Clears app caches and temporary files (preserves login)
* **Hard Reset**: Clears caches, device data, and settings (requires re-login)
* **Clear Authentication**: Removes Samsung Account database and credentials
* **Repair Permissions**: Fixes ACLs on app folders
* **Re-register Apps**: Re-registers AppX manifests to fix launch issues
* **Factory Reset**: Completely wipes ALL Samsung data (credentials, devices, DBs, settings)

## Package Profiles

### Core Only

Essential packages for basic Samsung ecosystem functionality:

* Samsung Account
* Samsung Settings + Runtime
* Samsung Cloud
* Knox Matrix for Windows
* Samsung Continuity Service
* Samsung Intelligence Service
* Samsung Bluetooth Sync
* Galaxy Book Experience

### Recommended

Core packages + all fully working Samsung apps:

* Quick Share (requires Intel Wi-Fi for best results)
* Samsung Notes
* Multi Control
* Samsung Gallery
* Samsung Studio + Studio for Gallery
* Samsung Screen Recorder
* Samsung Flow
* SmartThings
* Galaxy Buds Manager
* Samsung Parental Controls
* AI Select
* Nearby Devices
* Storage Share
* Second Screen
* Live Wallpaper
* Galaxy Book Smart Switch
* Samsung Pass

### Full Experience

Recommended + apps requiring extra configuration:

* Samsung Phone (needs additional setup)
* Samsung Find (needs additional setup)
* Quick Search (needs additional setup)

### Everything

All packages including non-functional ones:

* ⚠️ Samsung Recovery (won't work)
* ⚠️ Samsung Update (won't work)

### Custom Selection

Pick individual packages by category with detailed descriptions and warnings.

## Package Compatibility Matrix

| Package                      | Status           | Intel Wi-Fi + BT Required for Full Support | Notes                                                                  |
| ---------------------------- | ---------------- | ------------------------------------------ | ---------------------------------------------------------------------- |
| Samsung Account              | ✅ Working        | No                                         | Required                                                               |
| Samsung Settings             | ✅ Working        | No                                         | Required                                                               |
| Samsung Settings Runtime     | ✅ Working        | No                                         | Required                                                               |
| Samsung Cloud Assistant      | ✅ Working        | No                                         | Required                                                               |
| Samsung Continuity Service   | ✅ Working        | No                                         | Core service works; continuity reliability is best on Intel Wi-Fi + BT |
| Samsung Intelligence Service | ✅ Working        | No                                         | Required (AI features)                                                 |
| Samsung Bluetooth Sync       | ✅ Working        | No                                         | Required                                                               |
| Galaxy Book Experience       | ✅ Working        | No                                         | Core (app catalog)                                                     |
| Quick Share                  | ✅ Working        | **Yes**                                    | Requires Intel Wi-Fi + Intel Bluetooth                                 |
| Camera Share                 | ✅ Working        | **Yes**                                    | Requires Intel Wi-Fi + Intel Bluetooth                                 |
| Samsung Notes                | ✅ Working        | No                                         | -                                                                      |
| Multi Control                | 🔍 Investigating | **Yes**                                    | Under investigation; full reliability requires Intel Wi-Fi + BT        |
| Samsung Gallery              | ✅ Working        | No                                         | -                                                                      |
| Samsung Studio               | ✅ Working        | No                                         | -                                                                      |
| Samsung Studio for Gallery   | ✅ Working        | No                                         | -                                                                      |
| Samsung Screen Recorder      | ⚠️ Working       | No                                         | Shows "optimized for Galaxy Books"                                     |
| Samsung Flow                 | ✅ Working        | No                                         | -                                                                      |
| SmartThings                  | ✅ Working        | No                                         | -                                                                      |
| Galaxy Buds                  | ✅ Working        | No                                         | MultiPoint supported via Samsung Settings                              |
| Samsung Parental Controls    | ✅ Working        | No                                         | -                                                                      |
| AI Select                    | ✅ Working        | No                                         | -                                                                      |
| Nearby Devices               | ✅ Working        | No                                         | -                                                                      |
| Storage Share                | ⚠️ Limited       | **Yes**                                    | Best with Intel Wi-Fi + Intel Bluetooth                                |
| Second Screen                | ⚠️ Limited       | **Yes**                                    | Best with Intel Wi-Fi + Intel Bluetooth                                |
| Live Wallpaper               | ✅ Working        | No                                         | -                                                                      |
| Galaxy Book Smart Switch     | ✅ Working        | No                                         | -                                                                      |
| Samsung Pass                 | ✅ Working        | No                                         | -                                                                      |
| Samsung Device Care          | ⚠️ Extra Steps   | No                                         | May not function properly                                              |
| Samsung Phone                | ⚠️ Extra Steps   | No                                         | Configuration required                                                 |
| Samsung Find                 | ⚠️ Extra Steps   | No                                         | Configuration required                                                 |
| Quick Search                 | ⚠️ Extra Steps   | No                                         | Configuration required                                                 |
| Samsung Recovery             | ❌ Not Working    | No                                         | Requires genuine hardware                                              |
| Samsung Update               | ❌ Not Working    | No                                         | Requires genuine hardware                                              |

## System Requirements

### Required

* Windows 10/11 (64-bit)
* PowerShell 7.0 or later
* Administrator privileges
* Active Internet connection

### Recommended for Full Experience

* Intel Wi-Fi adapter (for Quick Share and related Wi-Fi Direct features)
* Intel Bluetooth adapter
* 8GB RAM or more
* Samsung account

### System Support Engine (Optional Advanced Feature)

* **Windows 11 (Build 22000+)** - Required
* **x64 architecture** - Recommended
* **ARM** - Experimental warning shown, not officially supported
* **Advanced users only** - Involves binary patching and service creation
* **Experimental** - May cause system instability or trigger antivirus warnings

## Wi-Fi & Bluetooth Compatibility

Galaxy Book Enabler now performs a **hardware compatibility check before installation**. The installer detects your **CPU**, **Wi-Fi**, and **Bluetooth** platforms and shows a feature support summary before you choose a profile.

### Detected Hardware Platforms

#### CPU detection

* **Intel** - Full support
* **AMD Ryzen** - Supported for many apps and features, with hardware-dependent limitations for some wireless features
* **ARM** - Experimental warning shown during install

#### Wi-Fi detection

The installer checks vendor IDs for:

* **Intel** (`8086`)
* **MediaTek / AMD RZ-series** (`14C3`)
* **Realtek** (`10EC`)
* **Qualcomm** (`168C`, `17CB`)

#### Bluetooth detection

The installer checks vendor IDs for:

* **Intel** (`8087`)
* **MediaTek** (`0E8D`)
* **Realtek** (`0BDA`)

### Feature Support Summary

* **Samsung Notes / Bixby / AI Select** - Works regardless of Wi-Fi platform
* **Galaxy Buds / MultiPoint** - Works regardless of Wi-Fi platform
* **Samsung Settings / Knox / Pass** - Works regardless of Wi-Fi platform
* **Quick Share / Camera Share / Storage Share** - Require Intel Wi-Fi for full support
* **Multi Control / Second Screen** - Most reliable with Intel Wi-Fi + Intel Bluetooth
* **Continuity Service** - Best results with Intel Wi-Fi + Intel Bluetooth

### AMD Ryzen Systems

AMD systems are supported, but the best experience depends heavily on the Wi-Fi and Bluetooth chipset in the machine.

* If your AMD system has **Intel Wi-Fi + Intel Bluetooth**, wireless Samsung features have the best chance of working properly
* If your AMD system uses **MediaTek**, **Realtek**, or **Qualcomm** Wi-Fi, expect **Samsung Notes**, **Galaxy Buds**, **Samsung Settings**, **Knox**, and similar apps to work, but **Quick Share**, **Camera Share**, and **Storage Share** are not expected to work correctly
* For AMD systems, the installer guidance currently favors **Galaxy Book5 Pro (`960XHA`)** or **Galaxy Book6 Pro (`960XKA`)** profiles

### Wi-Fi Compatibility by Generation

The table below focuses on the wireless Samsung features that depend on Wi-Fi Direct and related stack behavior.

| Generation               | Adapters                    | Quick Share  | Multi Control    | Second Screen | Camera Share | Storage Share |
| ------------------------ | --------------------------- | ------------ | ---------------- | ------------- | ------------ | ------------- |
| **Wi-Fi 7 (BE)**         | BE200, BE201, BE202         | ✅ Full       | 🔍 Investigating | ✅ Full        | ✅ Full       | ✅ Full        |
| **Wi-Fi 6E (AX)**        | AX210, AX211, AX411         | ✅ Full       | 🔍 Investigating | ✅ Full        | ✅ Full       | ✅ Full        |
| **Wi-Fi 6 (AX)**         | AX201, AX200                | ✅ Full       | 🔍 Investigating | ✅ Full        | ✅ Full       | ✅ Full        |
| **Wi-Fi 5 (AC)**         | 9260, 9560, 8265, 8260      | ✅ Works      | ❌ Not Working    | ❌ Not Working | ✅ Works      | ✅ Works       |
| **Wireless-AC (Legacy)** | 7265, 7260, 3168, 3165      | ❓ Not Tested | ❌ Not Working    | ❌ Not Working | ❓ Not Tested | ❓ Not Tested  |
| **Non-Intel**            | Realtek, MediaTek, Qualcomm | ❌            | ❌ / Limited      | ❌ / Limited   | ❌            | ❌             |

### Intel Wi-Fi Product Families

#### Wi-Fi 7 (BE) - Full Compatibility ✅

| Product             | Launch | Max Speed | Notes                     |
| ------------------- | ------ | --------- | ------------------------- |
| Intel Wi-Fi 7 BE200 | Q3'23  | 5.8 Gbps  | 320 MHz, 4096 QAM         |
| Intel Wi-Fi 7 BE201 | Q2'24  | 5.8 Gbps  | Double Connect Technology |
| Intel Wi-Fi 7 BE202 | Q3'23  | 2.4 Gbps  | 160 MHz, 1024 QAM         |

#### Wi-Fi 6E (AX) - Full Compatibility ✅

| Product                     | Launch | Max Speed | Notes                     |
| --------------------------- | ------ | --------- | ------------------------- |
| Intel Wi-Fi 6E AX411 (Gig+) | Q4'21  | ~3.0 Gbps | Double Connect Technology |
| Intel Wi-Fi 6E AX211 (Gig+) | Q3'21  | 2.4 Gbps  | Most common 6E adapter    |
| Intel Wi-Fi 6E AX210 (Gig+) | Q4'20  | 2.4 Gbps  | First consumer 6E         |

#### Wi-Fi 6 (AX) - Full Compatibility ✅

* Intel Wi-Fi 6 AX201/AX200
* Intel Killer Wi-Fi 6 variants

#### Wi-Fi 5 / Wireless-AC - Limited Compatibility ⚠️

| Product Family                             | Quick Share | Multi Control | Second Screen |
| ------------------------------------------ | ----------- | ------------- | ------------- |
| Intel Wireless-AC 9000 Series (9260, 9560) | ✅ Works     | ❌ No          | ❌ No          |
| Intel Wireless-AC 8000 Series (8265, 8260) | ✅ Works     | ❌ No          | ❌ No          |

**AC Limitations:**

* Multi Control does not work reliably
* Second Screen does not work
* Quick Share may show driver or software update errors on some systems

#### Legacy Wireless-AC - Not Tested ❓

| Product Family              | Status                    |
| --------------------------- | ------------------------- |
| Intel Wireless-AC 7265/7260 | Not tested - may not work |
| Intel Wireless-AC 3168/3165 | Not tested - may not work |

> **⚠️ Legacy Warning**: These older adapters may not work if:
>
> * Driver hasn't been updated since 2020
> * Product is discontinued without Windows 10/11 driver support
> * Adapter doesn't support modern Wi-Fi Direct features

### Multi Control Status: Under Investigation 🔍

Multi Control is currently **not working reliably** on any platform:

* Works intermittently on some Intel Wi-Fi 6/6E/7 systems
* Completely unreliable on many non-Intel setups
* Investigation is ongoing

### Intel Bluetooth (Required for Full Wireless Features) ✅

All major wireless features also require an **Intel Bluetooth radio** in addition to compatible Wi-Fi. Third-party Bluetooth adapters and mismatched wireless stacks may cause features to fail with unclear errors.

### Alternative for Non-Intel Users

If you don't have Intel Wi-Fi **and** Intel Bluetooth, consider **Google Nearby Share** as an alternative:

* Works with any Wi-Fi adapter
* Similar file-sharing functionality
* Cross-platform support (Windows, Android, ChromeOS)
* Download: [Google Nearby Share](https://www.android.com/better-together/nearby-share-app/)

[1]: https://raw.githubusercontent.com/Chiragsd13/GalaxyBookEnabler/main/README.md "raw.githubusercontent.com"

## Troubleshooting

### Verify Spoof Is Active

Run this in any PowerShell window to confirm the spoof was applied:

```powershell
Get-ItemProperty 'HKLM:\HARDWARE\DESCRIPTION\System\BIOS' |
    Select-Object SystemFamily, SystemProductName, SystemManufacturer, BIOSVersion
```

If values show your real hardware instead of Samsung, the startup task hasn't run yet. Reboot, or run the spoof script manually as Administrator:

```powershell
& "$env:USERPROFILE\.galaxy-book-enabler\GalaxyBookSpoof.bat"
```

After spoofing and rebooting, Samsung Settings will display the device as your chosen Galaxy Book model.

### Multi Control Stops Working After Reboot

- **Built-in recovery task**: Check Task Scheduler for `GalaxyBookEnabler-MultiControlInit`
- **Expected timing**: Task starts at boot +5 minutes, then waits 1 minute before restarting Samsung services
- **Run manually**: `pwsh -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\.galaxy-book-enabler\Init-SamsungMultiControlOnLogin.ps1"`
- Multi Control is under active investigation — works intermittently on Wi-Fi 6/6E/7 even on real Galaxy Books

### Nearby Devices Not Connecting

- Ensure you are signed into Samsung Account
- Sign out and back into Samsung Account, then reopen Nearby Devices
- Reboot after the spoof task runs and try again
- Nearby Devices does not require Intel Wi-Fi — it works on any adapter

### Apps Not Appearing or Not Recognising Device

- **Reboot required**: Some apps only read the BIOS identity at startup
- **Verify spoof**: Run the registry check above to confirm spoofing is active
- **Samsung Account**: Sign in to Samsung Account inside each app

### Quick Share Not Working

- Quick Share and Camera Share require **Intel Wi-Fi AX** (not AC) **and** Intel Bluetooth
- Check Device Manager → Network Adapters for your Wi-Fi adapter model
- Third-party Bluetooth (USB dongle, Realtek, MediaTek) will cause failures

### Installation Fails

- **Admin rights**: Must run PowerShell 7 as Administrator
- **Winget issues**: Run `winget upgrade --all` to update winget
- **Antivirus**: Temporarily disable if blocking installation

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for our development process.

1. Fork the repository
2. Create a feature branch
3. Test thoroughly on your hardware
4. Submit a pull request

## Credits

- Original script by [@obrobrio2000](https://github.com/obrobrio2000)
- Enhanced and maintained by [@Bananz0](https://github.com/Bananz0)
- v3.2.0 patch by Chirag Sood ([@Chiragsd13](https://github.com/Chiragsd13))

## Disclaimer

This tool is for educational and personal use only. Not affiliated with or endorsed by Samsung Electronics. Use at your own risk.

## License

MIT License — see the [LICENSE](LICENSE) file for details.

---

> Made with ❤️ for the Samsung ecosystem enthusiasts
