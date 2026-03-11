<#
.SYNOPSIS
    Tool Installer Menu by Afnan (PowerShell GUI Version)
.DESCRIPTION
    An interactive GUI to install essential developer tools and run automation scripts.
    Author: Afnan Siddiqui
#>

# Check for Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Requesting administrator privileges..."
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Helper Functions ---
function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Install-Choco {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Refresh-Path
    }
}

# --- Tool Definitions ---
$tools = @(
    @{ ID = 1; Name = "Afnan Portfolio"; Category = "Info"; Action = { Start-Process "https://afnanportfolio1.netlify.app/" } },
    @{ ID = 2; Name = "See Policy"; Category = "System"; Action = { Get-ExecutionPolicy -List | Out-String | Write-Host } },
    @{ ID = 3; Name = "Unrestrict Policy"; Category = "System"; Action = { Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine; Write-Host "Policy updated." } },
    @{ ID = 4; Name = "Chocolatey"; Category = "Essential"; Action = { Install-Choco } },
    @{ ID = 5; Name = "Node.js LTS"; Category = "Essential"; Action = { Install-Choco; choco install nodejs-lts -y; Refresh-Path } },
    @{ ID = 6; Name = "Chris Titus Tool"; Category = "Scripts"; Action = { irm 'https://christitus.com/win' | iex } },
    @{ ID = 7; Name = "Mass Grave"; Category = "Scripts"; Action = { irm https://get.activated.win | iex } },
    @{ ID = 8; Name = "Coporton Tool"; Category = "Scripts"; Action = { Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://coporton.com/ias | iex`"" } },
    @{ ID = 9; Name = "Git"; Category = "Essential"; Action = { Install-Choco; choco install git -y; Refresh-Path } },
    @{ ID = 10; Name = "Python"; Category = "Essential"; Action = { Install-Choco; choco install python -y; Refresh-Path } },
    @{ ID = 11; Name = ".NET"; Category = "Dev Tools"; Action = { Install-Choco; choco install dotnet -y; Refresh-Path } },
    @{ ID = 12; Name = "FFmpeg"; Category = "Dev Tools"; Action = { Install-Choco; choco install ffmpeg -y; Refresh-Path } },
    @{ ID = 13; Name = "7-Zip"; Category = "Utilities"; Action = { Install-Choco; choco install 7zip -y; Refresh-Path } },
    @{ ID = 14; Name = "WinDirStat"; Category = "Utilities"; Action = { Install-Choco; choco install windirstat -y } },
    @{ ID = 15; Name = "yt-dlp"; Category = "Utilities"; Action = { Install-Choco; choco install yt-dlp -y } },
    @{ ID = 16; Name = "ngrok"; Category = "Dev Tools"; Action = { Install-Choco; choco install ngrok -y } },
    @{ ID = 17; Name = "n8n"; Category = "Automation"; Action = {
        if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { Install-Choco; choco install nodejs-lts -y; Refresh-Path }
        Start-Process cmd -ArgumentList "/k npm install -g n8n@latest --verbose"
    } },
    @{ ID = 18; Name = "Gemini CLI"; Category = "AI"; Action = {
        if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { Install-Choco; choco install nodejs-lts -y; Refresh-Path }
        Start-Process cmd -ArgumentList "/k npm install -g @google/gemini-cli@latest --verbose"
    } },
    @{ ID = 19; Name = "Qwen CLI"; Category = "AI"; Action = {
        if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { Install-Choco; choco install nodejs-lts -y; Refresh-Path }
        Start-Process cmd -ArgumentList "/k npm install -g @qwen-code/qwen-code@latest --verbose"
    } },
    @{ ID = 20; Name = "Win 11 Menu"; Category = "Tweaks"; Action = { reg delete HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f; Stop-Process -Name explorer -Force; Start-Process explorer } },
    @{ ID = 21; Name = "Win 10 Menu"; Category = "Tweaks"; Action = { reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve; Stop-Process -Name explorer -Force; Start-Process explorer } },
    @{ ID = 22; Name = "Winget"; Category = "System"; Action = {
        Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'
        Add-AppxPackage 'winget.msixbundle'
        Remove-Item 'winget.msixbundle' -Force
    } },
    @{ ID = 23; Name = "Office 365"; Category = "Apps"; Action = {
        $url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"
        Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\OfficeSetup.exe"
        Start-Process "$env:TEMP\OfficeSetup.exe"
    } },
    @{ ID = 24; Name = "Everything"; Category = "Utilities"; Action = { Install-Choco; choco install everything -y } },
    @{ ID = 25; Name = "Chrome"; Category = "Apps"; Action = { Install-Choco; choco install googlechrome -y } },
    @{ ID = 26; Name = "Zen Browser"; Category = "Apps"; Action = {
        $url = "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe"
        Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\zen-installer.exe"
        Start-Process "$env:TEMP\zen-installer.exe" -Wait
    } },
    @{ ID = 27; Name = "Clone Elegant"; Category = "Dev Tools"; Action = {
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Install-Choco; choco install git -y; Refresh-Path }
        git clone https://github.com/afnan-nex/Elegant
    } },
    @{ ID = 28; Name = "CMD Color 0a"; Category = "Tweaks"; Action = { irm 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' | iex } },
    @{ ID = 29; Name = "OBS Studio"; Category = "Apps"; Action = { Install-Choco; choco install obs-studio -y } },
    @{ ID = 30; Name = "RustDesk"; Category = "Apps"; Action = { Install-Choco; choco install rustdesk -y } },
    @{ ID = 31; Name = "HiBit Uninstaller"; Category = "Utilities"; Action = {
        $url = "https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe"
        Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\HiBitSetup.exe"
        Start-Process "$env:TEMP\HiBitSetup.exe" -Wait
    } },
    @{ ID = 32; Name = "Scrcpy GUI"; Category = "Utilities"; Action = {
        $url = "https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe"
        Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\ScrcpyGUI_Setup.exe"
        Start-Process "$env:TEMP\ScrcpyGUI_Setup.exe" -Wait
    } },
    @{ ID = 33; Name = "LocalSend"; Category = "Apps"; Action = { Install-Choco; choco install localsend -y } },
    @{ ID = 34; Name = "Notepad++"; Category = "Apps"; Action = { Install-Choco; choco install notepadplusplus -y } },
    @{ ID = 35; Name = "ShareX"; Category = "Apps"; Action = { Install-Choco; choco install sharex -y } },
    @{ ID = 36; Name = "VC++ Runtimes"; Category = "System"; Action = {
        $url = "https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
        $zip = "$env:TEMP\VC_Runtimes.zip"
        Invoke-WebRequest -Uri $url -OutFile $zip
        if (Test-Path "$env:TEMP\VC_Runtimes") { Remove-Item "$env:TEMP\VC_Runtimes" -Recurse -Force }
        Expand-Archive -Path $zip -DestinationPath "$env:TEMP\VC_Runtimes" -Force
        $is = Get-ChildItem -Path "$env:TEMP\VC_Runtimes" -Filter "install_all.bat" -Recurse | Select-Object -First 1
        if ($is) { Start-Process $is.FullName -Verb RunAs }
    } },
    @{ ID = 37; Name = "DirectX"; Category = "System"; Action = {
        $url = "https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
        $zip = "$env:TEMP\DirectX.zip"
        Invoke-WebRequest -Uri $url -OutFile $zip
        if (Test-Path "$env:TEMP\DirectX_Install") { Remove-Item "$env:TEMP\DirectX_Install" -Recurse -Force }
        Expand-Archive -Path $zip -DestinationPath "$env:TEMP\DirectX_Install" -Force
        $s = Get-ChildItem -Path "$env:TEMP\DirectX_Install" -Filter "DXSETUP.exe" -Recurse | Select-Object -First 1
        if ($s) { Start-Process $s.FullName -Verb RunAs }
    } }
)

# --- GUI Construction ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Tools Installer GUI by Afnan"
$form.Size = New-Object System.Drawing.Size(900, 800)
$form.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.StartPosition = "CenterScreen"

$title = New-Object System.Windows.Forms.Label
$title.Text = "Tools Installer Menu by Afnan"
$title.Font = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$title.ForeColor = [System.Drawing.Color]::FromArgb(0, 255, 150)
$title.Location = New-Object System.Drawing.Point(20, 15)
$title.AutoSize = $true
$form.Controls.Add($title)

$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(20, 80)
$tabControl.Size = New-Object System.Drawing.Size(840, 520)
$form.Controls.Add($tabControl)

$categories = $tools | Group-Object Category
$checkboxes = @()

foreach ($cat in $categories) {
    $tabPage = New-Object System.Windows.Forms.TabPage
    $tabPage.Text = $cat.Name
    $tabPage.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)

    $flowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $flowPanel.Dock = "Fill"
    $flowPanel.Padding = New-Object System.Windows.Forms.Padding(20)
    $flowPanel.AutoScroll = $true
    $tabPage.Controls.Add($flowPanel)

    foreach ($tool in $cat.Group) {
        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text = $tool.Name
        $cb.Size = New-Object System.Drawing.Size(240, 35)
        $cb.Tag = $tool
        $checkboxes += $cb
        $flowPanel.Controls.Add($cb)
    }

    $tabControl.TabPages.Add($tabPage)
}

$btnSelectAll = New-Object System.Windows.Forms.Button
$btnSelectAll.Text = "Select All"
$btnSelectAll.Location = New-Object System.Drawing.Point(20, 610)
$btnSelectAll.Size = New-Object System.Drawing.Size(120, 30)
$btnSelectAll.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 60)
$btnSelectAll.FlatStyle = "Flat"
$btnSelectAll.Add_Click({ $checkboxes | ForEach-Object { $_.Checked = $true } })
$form.Controls.Add($btnSelectAll)

$btnDeselectAll = New-Object System.Windows.Forms.Button
$btnDeselectAll.Text = "Deselect All"
$btnDeselectAll.Location = New-Object System.Drawing.Point(150, 610)
$btnDeselectAll.Size = New-Object System.Drawing.Size(120, 30)
$btnDeselectAll.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 60)
$btnDeselectAll.FlatStyle = "Flat"
$btnDeselectAll.Add_Click({ $checkboxes | ForEach-Object { $_.Checked = $false } })
$form.Controls.Add($btnDeselectAll)

$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "Run Selected"
$btnRun.Location = New-Object System.Drawing.Point(20, 660)
$btnRun.Size = New-Object System.Drawing.Size(160, 50)
$btnRun.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btnRun.FlatStyle = "Flat"
$btnRun.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$btnRun.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnRun.Add_Click({
    $selected = $checkboxes | Where-Object { $_.Checked }
    if ($selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Please select at least one tool.", "No Selection")
        return
    }

    foreach ($cb in $selected) {
        $t = $cb.Tag
        Write-Host ">>> Executing: $($t.Name)" -ForegroundColor Cyan
        try {
            & $t.Action
        } catch {
            Write-Warning "Failed to execute $($t.Name): $($_.Exception.Message)"
        }
    }
    [System.Windows.Forms.MessageBox]::Show("Selected tasks completed!", "Finished")
})
$form.Controls.Add($btnRun)

$btnRunAll = New-Object System.Windows.Forms.Button
$btnRunAll.Text = "Install Recommended"
$btnRunAll.Location = New-Object System.Drawing.Point(200, 660)
$btnRunAll.Size = New-Object System.Drawing.Size(220, 50)
$btnRunAll.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)
$btnRunAll.FlatStyle = "Flat"
$btnRunAll.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$btnRunAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnRunAll.Add_Click({
    $recIds = @(4, 5, 9, 10, 12, 13, 15, 24, 25, 29, 34, 28)
    foreach ($tool in $tools) {
        if ($recIds -contains $tool.ID) {
            Write-Host ">>> Installing Recommended: $($tool.Name)" -ForegroundColor Green
            try { & $tool.Action } catch {}
        }
    }
    [System.Windows.Forms.MessageBox]::Show("Recommended tools installation finished!", "Finished")
})
$form.Controls.Add($btnRunAll)

$btnUpdate = New-Object System.Windows.Forms.Button
$btnUpdate.Text = "Self Update"
$btnUpdate.Location = New-Object System.Drawing.Point(710, 660)
$btnUpdate.Size = New-Object System.Drawing.Size(150, 50)
$btnUpdate.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$btnUpdate.FlatStyle = "Flat"
$btnUpdate.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnUpdate.Add_Click({
    $url = "https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.ps1"
    try {
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop).Content
        if ($content.Length -gt 1000) {
            $content | Set-Content $PSCommandPath
            [System.Windows.Forms.MessageBox]::Show("Script updated successfully! Please restart the script.", "Success")
            $form.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("Downloaded content seems too short. Update aborted.", "Warning")
        }
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to update: $($_.Exception.Message)", "Error")
    }
})
$form.Controls.Add($btnUpdate)

$footer = New-Object System.Windows.Forms.Label
$footer.Text = "Created by Afnan Siddiqui | Follow on Instagram: @afnan-nex"
$footer.Location = New-Object System.Drawing.Point(20, 730)
$footer.AutoSize = $true
$footer.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($footer)

$form.ShowDialog()
