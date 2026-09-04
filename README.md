# **Tooler**

A modern Windows WPF GUI application wrapper for `tooler.ps1` to quickly install developer tools, productivity apps, system utilities, and run optimization/automation scripts. It simplifies the setup of essential environments and configurations on Windows systems.

## Quick Start

### Run (PowerShell)
```powershell
irm https://raw.githubusercontent.com/afnan-nex/tooler/main/run.ps1 | iex
```

### Install CLI to PATH & Create Shortcuts (PowerShell)
```powershell
irm https://raw.githubusercontent.com/afnan-nex/tooler/main/install.ps1 | iex
```

<p align="center">
  <img src="https://img.shields.io/badge/version-2.1-blue.svg?style=for-the-badge" alt="Version 2.1">
  <a href="https://raw.githubusercontent.com/afnan-nex/tooler/refs/heads/main/Setup/Tooler.exe">
    <img src="https://img.shields.io/badge/Download-Setup.exe-blue?style=for-the-badge&logo=windows" alt="Download Setup">
  </a>
</p>

<details>
  <summary>Other commands</summary>

## **Run in CMD**
```cmd
curl -L -o "%TEMP%\tooler.ps1" https://raw.githubusercontent.com/afnan-nex/tooler/main/tooler.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tooler.ps1"
```

## **Run in CMD (Beta)**
```cmd
curl -L -o "%TEMP%\tooler-beta.ps1" https://raw.githubusercontent.com/afnan-nex/tooler/main/tooler-beta.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tooler-beta.ps1"
```

## **Run Beta in PowerShell**
```powershell
$Beta = $true; irm https://raw.githubusercontent.com/afnan-nex/tooler/main/run.ps1 | iex
```

## **For Security Problem**
Might I make it Permanent
```cmd
curl -L -o "%TEMP%\tooler.ps1" https://raw.githubusercontent.com/afnan-nex/tooler/main/tooler.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tooler.ps1"
```

## **Curl Command**
```cmd
curl -o tooler.cmd https://raw.githubusercontent.com/afnan-nex/tooler/main/Other/tooler.cmd && tooler.cmd
```

## **Run in PowerShell or CMD 🖥️**
```ps1
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/afnan-nex/tooler/main/Other/tooler.cmd?$(Get-Date -Format yyyyMMddHHmmss)' -OutFile tooler.cmd; Start-Process tooler.cmd"
```

## **To Run Strictly in Powershell**
```ps1
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/afnan-nex/tooler/main/Other/tooler.cmd?$(Get-Date -Format yyyyMMddHHmmss)" -OutFile "$env:TEMP\tooler.cmd";
Start-Process "$env:TEMP\tooler.cmd" -Verb RunAs
```

## **Install via Setup Installer**
Run the [Setup installer](https://raw.githubusercontent.com/afnan-nex/tooler/refs/heads/main/Setup/Tooler.exe), which automatically installs `tooler.exe` and adds it to your system `PATH`.
</details>

---

## **Features**

*   **Modern WPF XAML GUI**: A clean, hardware-accelerated dark theme dashboard that renders all categories in responsive columns.
*   **Instant Search Filtering**: Type in the search box to filter categories and applications instantly. Pressing **Enter** when a single match is displayed will launch it immediately, automatically highlighting the search box for your next query.
*   **Intuitive Keyboard Navigation**:
    *   **Arrow Keys**: Move focus between buttons/columns. Navigating Left/Right matches the closest vertical button in the next column rather than resetting to the top of the list.
    *   **Spacebar**: Toggles the checkbox next to the focused tool to queue/select it for a batch run.
    *   **Enter**: Executes all checked items simultaneously in the background (Run Selected) and unselects/clears all checkboxes when finished.
*   **Distinct Taskbar Branding**: Uses Win32 API overrides to separate the application process group from standard PowerShell windows, displaying the custom app icon natively on the Windows taskbar.
*   **Non-Blocking Executions**: Individual scripts run in dedicated background sessions, allowing the main GUI to remain fully responsive.

---

## **Categorized Tools & Scripts**

### 1. **Essential & Package Managers**
*   Chocolatey, Scoop, Node.js LTS, pnpm, Yarn, Bun, Go, Deno.

### 2. **PowerShell & Tweaks**
*   See execution policy, Unrestrict PowerShell execution policies.

### 3. **Run Scripts & Optimizations**
*   Chris Titus Tool, Mass Grave (Windows Activation), Win11 Debloat, WinScript, Coporton, IDM Fixer, Sparkle, GHGrab, Tooler Setup, VPN, Tor Link, Tork, YTDLP Frontend, Yoinks.

### 4. **AI Assistants & Tools**
*   Agy, Antigravity Manager, Opencode, Cursor IDE, Google Desktop App, LLM-Checker, LLMFit, Ollama, Claude Code, Claude Code Router, Codebuff, Omniroute.

### 5. **System Tools & Runtimes**
*   Winget, Everything Search, CMD Color 0a, RustDesk, HiBit Uninstaller, Superfile, Alacritty, Scrcpy GUI, Cursor / Elegant repository, VC++ Runtimes, DirectX Runtime.

### 6. **Control Panel Access**
*   Classic Control Panel, Devices and Printers, Task Manager, Device Manager, Disk Management, System Properties, System Config (MSConfig), Power Options.

### 7. **Productivity Apps**
*   Office 365, Google Chrome, Zen Browser, OBS Studio, LocalSend, Notepad++, ShareX, qBittorrent.

### 8. **Diagnostics & Data Recovery**
*   TestDisk, FreeRecover, Kickass Undelete, CPU-Z, HWiNFO, GPU-Z, CrystalDiskInfo, CrystalDiskMark, DriverStore Explorer, Ventoy, Rufus, AnyBurn, Git Cloner, Downly, Monkeytype TUI.

---

## **Prerequisites**

*   Windows 10 / 11.
*   Administrative privileges (STA mode runspace).
*   Internet connection to download packages.

## **Usage**

1. Run the script using the recommended commands above.
2. Select tools by checking the boxes next to them.
3. Click **Run selected** (or press **Enter**) to run the batch installer.
4. Or, click any button (or focus and press a standard click trigger) to execute it immediately.

## **License**

This project is licensed under the MIT License. See the [LICENSE](https://github.com/afnan-nex/tooler/blob/main/LICENSE) file for details.

## **Author**

Created by AFNAN with ❤️.

Portfolio: [https://afnan-nex.github.io/portfolio/](https://afnan-nex.github.io/portfolio/).

Instagram: [@afnan-nex](https://instagram.com/afnan-nex).

## **Disclaimer**

This script downloads and executes third-party tools and scripts. Use at your own risk. The author is not responsible for any damages or issues caused by the use of this script.

---
*"Once you get addicted to winning, no chance you would lose. Work 24/7 and when you start see yourself going up, you would see that the before was boring. The first time win is difficult; once you won you would see that it is not that difficult, you have done it before."*
