# Tooler CLI Binary

This directory contains the C++ source code and build script to generate `tooler.exe`, a lightweight CLI wrapper for Tooler.

## How It Works
When you execute `tooler` from any terminal or command prompt, it runs:
```cmd
curl -L -o "%TEMP%\tooler.ps1" https://raw.githubusercontent.com/afnan-nex/tooler/main/tooler.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tooler.ps1"
```

## How to Add to Environment Variables (PATH)

### Option 1: PowerShell (Quick Setup)
Run this command in PowerShell (as Administrator or Current User):
```powershell
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User") + ";C:\Users\Admin\Desktop\tools-installer-main\binary", "User")
```
*(Replace path if repository is moved)*

### Option 2: Windows Settings GUI
1. Press `Win + R`, type `sysdm.cpl` and hit Enter.
2. Go to the **Advanced** tab and click **Environment Variables**.
3. Under **User variables** (or **System variables**), select **Path** and click **Edit**.
4. Click **New** and paste the full folder path to this `binary` folder.
5. Click **OK** on all dialogs.
6. Open a new Command Prompt or PowerShell and type `tooler`.

## Building from Source

### Using G++ / MinGW:
```cmd
build.bat
```
Or manually:
```cmd
windres resource.rc -O coff -o resource.res
g++ -O3 -std=c++17 tooler.cpp resource.res -o tooler.exe -static
```

### Using MSVC (cl.exe):
```cmd
cl /O2 /EHsc tooler.cpp /Fe:tooler.exe
```
