#Requires -Version 5.1
<#
.SYNOPSIS
    Tools Installer Menu by Afnan - v2.0 (Enhanced)
.DESCRIPTION
    High-performance interactive GUI to install developer tools and run automation scripts.
    Author: Afnan
#>

# Admin Elevation
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::SetCompatibleTextRenderingDefault($false)

# --- Colour Palette ---
$c = @{
    Bg        = [System.Drawing.Color]::FromArgb(18, 18, 24)
    Surface   = [System.Drawing.Color]::FromArgb(28, 28, 38)
    Surface2  = [System.Drawing.Color]::FromArgb(38, 38, 52)
    Accent    = [System.Drawing.Color]::FromArgb(99, 102, 241)
    Green     = [System.Drawing.Color]::FromArgb(34, 197, 94)
    Red       = [System.Drawing.Color]::FromArgb(239, 68, 68)
    Yellow    = [System.Drawing.Color]::FromArgb(234, 179, 8)
    Text      = [System.Drawing.Color]::FromArgb(230, 230, 245)
    TextDim   = [System.Drawing.Color]::FromArgb(130, 130, 160)
    TabSel    = [System.Drawing.Color]::FromArgb(48, 48, 68)
}

# --- Fonts ---
$fTitle = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$fBold  = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$fNorm  = New-Object System.Drawing.Font("Segoe UI", 9)
$fSmall = New-Object System.Drawing.Font("Segoe UI", 8)
$fMono  = New-Object System.Drawing.Font("Consolas", 8.5)

# --- Helpers ---
function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}

function Install-Choco {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Refresh-Path
    }
}

function Ensure-NPM {
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Install-Choco; choco install nodejs-lts -y; Refresh-Path
    }
}

function Ensure-Git {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Install-Choco; choco install git -y; Refresh-Path
    }
}

# --- Tool Definitions ---
$tools = @(
    @{ ID=1;  Name="Afnan Portfolio";     Category="Info";       Desc="Open Afnan portfolio website";            Tags="web,info";
       Action={ Start-Process "https://afnanportfolio1.netlify.app/" } },

    @{ ID=2;  Name="See Policy";          Category="System";     Desc="Show current execution policies";         Tags="policy,security";
       Action={ Get-ExecutionPolicy -List | Out-String | Write-Host } },

    @{ ID=3;  Name="Unrestrict Policy";   Category="System";     Desc="Set execution policy to Unrestricted";    Tags="policy,security";
       Action={ Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser
                Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine
                Write-Host "Policy updated." } },

    @{ ID=4;  Name="Chocolatey";          Category="Essential";  Desc="Windows package manager";                 Tags="package,manager";
       Action={ Install-Choco } },

    @{ ID=5;  Name="Node.js LTS";         Category="Essential";  Desc="JavaScript runtime LTS";                  Tags="node,npm,javascript";
       Action={ Install-Choco; choco install nodejs-lts -y; Refresh-Path } },

    @{ ID=6;  Name="Chris Titus Tool";    Category="Scripts";    Desc="Windows debloat and tweaks utility";      Tags="tweak,debloat,windows";
       Action={ irm 'https://christitus.com/win' | iex } },

    @{ ID=7;  Name="Mass Grave";          Category="Scripts";    Desc="Windows and Office activation tool";      Tags="activate,windows,office";
       Action={ irm https://get.activated.win | iex } },

    @{ ID=8;  Name="Coporton Tool";       Category="Scripts";    Desc="Coporton automation script";              Tags="automation,script";
       Action={ Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://coporton.com/ias | iex`"" } },

    @{ ID=9;  Name="Git";                 Category="Essential";  Desc="Version control system";                  Tags="git,vcs,dev";
       Action={ Install-Choco; choco install git -y; Refresh-Path } },

    @{ ID=10; Name="Python";              Category="Essential";  Desc="Python programming language";             Tags="python,dev,language";
       Action={ Install-Choco; choco install python -y; Refresh-Path } },

    @{ ID=11; Name=".NET SDK";            Category="Dev Tools";  Desc="Microsoft .NET framework and SDK";        Tags="dotnet,csharp,microsoft";
       Action={ Install-Choco; choco install dotnet -y; Refresh-Path } },

    @{ ID=12; Name="FFmpeg";              Category="Dev Tools";  Desc="Audio and video processing toolkit";      Tags="ffmpeg,video,audio,media";
       Action={ Install-Choco; choco install ffmpeg -y; Refresh-Path } },

    @{ ID=13; Name="7-Zip";               Category="Utilities";  Desc="File archiver and compressor";            Tags="zip,compress,archive";
       Action={ Install-Choco; choco install 7zip -y; Refresh-Path } },

    @{ ID=14; Name="WinDirStat";          Category="Utilities";  Desc="Disk usage visualizer";                   Tags="disk,space,visualizer";
       Action={ Install-Choco; choco install windirstat -y } },

    @{ ID=15; Name="yt-dlp";              Category="Utilities";  Desc="YouTube and media downloader CLI";        Tags="youtube,download,media";
       Action={ Install-Choco; choco install yt-dlp -y } },

    @{ ID=16; Name="ngrok";               Category="Dev Tools";  Desc="Secure tunnel to localhost";              Tags="tunnel,localhost,ngrok";
       Action={ Install-Choco; choco install ngrok -y } },

    @{ ID=17; Name="n8n";                 Category="Automation"; Desc="Workflow automation platform";            Tags="automation,workflow,n8n";
       Action={ Ensure-NPM; Start-Process cmd -ArgumentList "/k npm install -g n8n@latest --verbose" } },

    @{ ID=18; Name="Gemini CLI";          Category="AI";         Desc="Google Gemini command-line tool";         Tags="ai,gemini,google,cli";
       Action={ Ensure-NPM; Start-Process cmd -ArgumentList "/k npm install -g @google/gemini-cli@latest --verbose" } },

    @{ ID=19; Name="Qwen CLI";            Category="AI";         Desc="Alibaba Qwen code assistant CLI";         Tags="ai,qwen,cli";
       Action={ Ensure-NPM; Start-Process cmd -ArgumentList "/k npm install -g @qwen-code/qwen-code@latest --verbose" } },

    @{ ID=20; Name="Win 11 Context Menu"; Category="Tweaks";     Desc="Restore Windows 11 right-click menu";    Tags="context,menu,explorer";
       Action={ reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
                Stop-Process -Name explorer -Force; Start-Process explorer } },

    @{ ID=21; Name="Win 10 Context Menu"; Category="Tweaks";     Desc="Classic Windows 10 right-click menu";    Tags="context,menu,classic";
       Action={ reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
                Stop-Process -Name explorer -Force; Start-Process explorer } },

    @{ ID=22; Name="Winget";              Category="System";     Desc="Microsoft package manager";               Tags="winget,package,microsoft";
       Action={ Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'
                Add-AppxPackage 'winget.msixbundle'; Remove-Item 'winget.msixbundle' -Force } },

    @{ ID=23; Name="Office 365";          Category="Apps";       Desc="Microsoft Office 365 installer";          Tags="office,microsoft,word,excel";
       Action={ $url = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"
                Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\OfficeSetup.exe"
                Start-Process "$env:TEMP\OfficeSetup.exe" } },

    @{ ID=24; Name="Everything";          Category="Utilities";  Desc="Instant file search tool";                Tags="search,file,fast";
       Action={ Install-Choco; choco install everything -y } },

    @{ ID=25; Name="Chrome";              Category="Apps";       Desc="Google Chrome browser";                   Tags="chrome,browser,google";
       Action={ Install-Choco; choco install googlechrome -y } },

    @{ ID=26; Name="Zen Browser";         Category="Apps";       Desc="Privacy-focused Firefox-based browser";   Tags="browser,zen,firefox,privacy";
       Action={ $url = "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe"
                Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\zen-installer.exe"
                Start-Process "$env:TEMP\zen-installer.exe" -Wait } },

    @{ ID=27; Name="Clone Elegant";       Category="Dev Tools";  Desc="Clone Afnan Elegant repo from GitHub";   Tags="git,clone,elegant";
       Action={ Ensure-Git; git clone https://github.com/afnan-nex/Elegant } },

    @{ ID=28; Name="CMD Color 0a";        Category="Tweaks";     Desc="Set CMD to green-on-black colour";        Tags="cmd,color,terminal";
       Action={ irm 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' | iex } },

    @{ ID=29; Name="OBS Studio";          Category="Apps";       Desc="Screen recording and streaming";          Tags="obs,recording,streaming";
       Action={ Install-Choco; choco install obs-studio -y } },

    @{ ID=30; Name="RustDesk";            Category="Apps";       Desc="Open-source remote desktop tool";         Tags="remote,desktop,rdp";
       Action={ Install-Choco; choco install rustdesk -y } },

    @{ ID=31; Name="HiBit Uninstaller";   Category="Utilities";  Desc="Advanced program uninstaller";            Tags="uninstall,clean,remove";
       Action={ $url = "https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe"
                Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\HiBitSetup.exe"
                Start-Process "$env:TEMP\HiBitSetup.exe" -Wait } },

    @{ ID=32; Name="Scrcpy GUI";          Category="Utilities";  Desc="Android screen mirror GUI app";           Tags="android,mirror,scrcpy";
       Action={ $url = "https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe"
                Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\ScrcpyGUI_Setup.exe"
                Start-Process "$env:TEMP\ScrcpyGUI_Setup.exe" -Wait } },

    @{ ID=33; Name="LocalSend";           Category="Apps";       Desc="LAN file sharing like AirDrop";           Tags="share,lan,file,local";
       Action={ Install-Choco; choco install localsend -y } },

    @{ ID=34; Name="Notepad++";           Category="Apps";       Desc="Advanced text and code editor";           Tags="editor,notepad,text";
       Action={ Install-Choco; choco install notepadplusplus -y } },

    @{ ID=35; Name="ShareX";              Category="Apps";       Desc="Screenshot and screen recorder";          Tags="screenshot,capture,sharex";
       Action={ Install-Choco; choco install sharex -y } },

    @{ ID=36; Name="VC++ Runtimes";       Category="System";     Desc="All Visual C++ redistributables";         Tags="vcredist,runtime,microsoft";
       Action={ $url = "https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
                $zip = "$env:TEMP\VC_Runtimes.zip"
                Invoke-WebRequest -Uri $url -OutFile $zip
                if (Test-Path "$env:TEMP\VC_Runtimes") { Remove-Item "$env:TEMP\VC_Runtimes" -Recurse -Force }
                Expand-Archive -Path $zip -DestinationPath "$env:TEMP\VC_Runtimes" -Force
                $is = Get-ChildItem "$env:TEMP\VC_Runtimes" -Filter "install_all.bat" -Recurse | Select-Object -First 1
                if ($is) { Start-Process $is.FullName -Verb RunAs } } },

    @{ ID=37; Name="DirectX";             Category="System";     Desc="DirectX redistributable Jun 2010";        Tags="directx,dx,gaming,runtime";
       Action={ $url = "https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
                $zip = "$env:TEMP\DirectX.zip"
                Invoke-WebRequest -Uri $url -OutFile $zip
                if (Test-Path "$env:TEMP\DirectX_Install") { Remove-Item "$env:TEMP\DirectX_Install" -Recurse -Force }
                Expand-Archive -Path $zip -DestinationPath "$env:TEMP\DirectX_Install" -Force
                $s = Get-ChildItem "$env:TEMP\DirectX_Install" -Filter "DXSETUP.exe" -Recurse | Select-Object -First 1
                if ($s) { Start-Process $s.FullName -Verb RunAs } } }
)

# --- State ---
$checkboxMap = @{}

$catColors = @{
    "Essential"  = [System.Drawing.Color]::FromArgb(34,  197, 94)
    "Dev Tools"  = [System.Drawing.Color]::FromArgb(59,  130, 246)
    "Utilities"  = [System.Drawing.Color]::FromArgb(168, 85,  247)
    "Apps"       = [System.Drawing.Color]::FromArgb(249, 115, 22)
    "AI"         = [System.Drawing.Color]::FromArgb(236, 72,  153)
    "Automation" = [System.Drawing.Color]::FromArgb(20,  184, 166)
    "Scripts"    = [System.Drawing.Color]::FromArgb(234, 179, 8)
    "System"     = [System.Drawing.Color]::FromArgb(148, 163, 184)
    "Tweaks"     = [System.Drawing.Color]::FromArgb(251, 146, 60)
    "Info"       = [System.Drawing.Color]::FromArgb(99,  102, 241)
}

# --- Button Factory ---
function Make-Button($text, $x, $y, $w, $h, $bg, $fg, $font) {
    $b = New-Object System.Windows.Forms.Button
    $b.Text = $text
    $b.Location = New-Object System.Drawing.Point($x, $y)
    $b.Size = New-Object System.Drawing.Size($w, $h)
    $b.BackColor = $bg; $b.ForeColor = $fg; $b.Font = $font
    $b.FlatStyle = "Flat"; $b.FlatAppearance.BorderSize = 0
    $b.Cursor = [System.Windows.Forms.Cursors]::Hand
    $hover = [System.Drawing.Color]::FromArgb(
        [Math]::Min($bg.R + 25, 255),
        [Math]::Min($bg.G + 25, 255),
        [Math]::Min($bg.B + 25, 255))
    $b.FlatAppearance.MouseOverBackColor = $hover
    return $b
}

# --- Log helper (thread-safe) ---
function Write-Log($msg, $colour) {
    if (-not $colour) { $colour = $c.Text }
    $script:logBox.Invoke([System.Action]{
        $script:logBox.SelectionStart  = $script:logBox.TextLength
        $script:logBox.SelectionLength = 0
        $script:logBox.SelectionColor  = $colour
        $ts = Get-Date -Format "HH:mm:ss"
        $script:logBox.AppendText("[$ts] $msg`n")
        $script:logBox.ScrollToCaret()
    })
}

# ============================================================
# FORM
# ============================================================
$form = New-Object System.Windows.Forms.Form
$form.Text           = "Tools Installer  by Afnan  v2.0"
$form.Size           = New-Object System.Drawing.Size(1060, 820)
$form.MinimumSize    = New-Object System.Drawing.Size(900, 700)
$form.BackColor      = $c.Bg
$form.ForeColor      = $c.Text
$form.Font           = $fNorm
$form.StartPosition  = "CenterScreen"
$form.DoubleBuffered = $true

# ---- Header ----
$header = New-Object System.Windows.Forms.Panel
$header.Dock = "Top"; $header.Height = 66; $header.BackColor = $c.Surface
$form.Controls.Add($header)

$titleLbl = New-Object System.Windows.Forms.Label
$titleLbl.Text = "Tools Installer"
$titleLbl.Font = $fTitle; $titleLbl.ForeColor = $c.Accent
$titleLbl.Location = New-Object System.Drawing.Point(20, 12); $titleLbl.AutoSize = $true
$header.Controls.Add($titleLbl)

$subLbl = New-Object System.Windows.Forms.Label
$subLbl.Text = "by Afnan Siddiqui  |  v2.0  |  Select tools and click Run Selected"
$subLbl.Font = $fSmall; $subLbl.ForeColor = $c.TextDim
$subLbl.Location = New-Object System.Drawing.Point(22, 46); $subLbl.AutoSize = $true
$header.Controls.Add($subLbl)

$selCount = New-Object System.Windows.Forms.Label
$selCount.Text = "0 selected"; $selCount.Font = $fBold; $selCount.ForeColor = $c.Accent
$selCount.AutoSize = $true
$selCount.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$header.Controls.Add($selCount)
$header.Add_Resize({
    $selCount.Location = New-Object System.Drawing.Point(($header.Width - $selCount.Width - 20), 24)
})

# ---- Search Bar ----
$searchPanel = New-Object System.Windows.Forms.Panel
$searchPanel.Dock = "Top"; $searchPanel.Height = 44; $searchPanel.BackColor = $c.Bg
$form.Controls.Add($searchPanel)

$searchLbl = New-Object System.Windows.Forms.Label
$searchLbl.Text = "Search:"; $searchLbl.Font = $fSmall; $searchLbl.ForeColor = $c.TextDim
$searchLbl.Location = New-Object System.Drawing.Point(20, 14); $searchLbl.AutoSize = $true
$searchPanel.Controls.Add($searchLbl)

$searchBox = New-Object System.Windows.Forms.TextBox
$searchBox.Location  = New-Object System.Drawing.Point(70, 10)
$searchBox.Size      = New-Object System.Drawing.Size(340, 26)
$searchBox.BackColor = $c.Surface2; $searchBox.ForeColor = $c.Text
$searchBox.Font      = $fNorm; $searchBox.BorderStyle = "FixedSingle"
$searchPanel.Controls.Add($searchBox)

$clearSearchBtn = Make-Button "X" 416 10 26 26 $c.Surface2 $c.TextDim $fSmall
$clearSearchBtn.Add_Click({ $searchBox.Text = "" })
$searchPanel.Controls.Add($clearSearchBtn)

# ---- Main SplitContainer ----
$split = New-Object System.Windows.Forms.SplitContainer
$split.Dock             = "Fill"
$split.BackColor        = $c.Bg
$split.SplitterWidth    = 5
$split.SplitterDistance = 615
$split.Panel1MinSize    = 480
$split.Panel2MinSize    = 240
$form.Controls.Add($split)

# ---- LEFT: TabControl ----
$tabCtrl = New-Object System.Windows.Forms.TabControl
$tabCtrl.Dock      = "Fill"
$tabCtrl.DrawMode  = [System.Windows.Forms.TabDrawMode]::OwnerDrawFixed
$tabCtrl.ItemSize  = New-Object System.Drawing.Size(108, 28)
$tabCtrl.SizeMode  = [System.Windows.Forms.TabSizeMode]::Fixed
$tabCtrl.BackColor = $c.Bg
$split.Panel1.Controls.Add($tabCtrl)

$tabCtrl.Add_DrawItem({
    param($s, $e)
    $tab   = $tabCtrl.TabPages[$e.Index]
    $rect  = $e.Bounds
    $isSel = ($e.Index -eq $tabCtrl.SelectedIndex)
    $bg    = if ($isSel) { $c.TabSel } else { $c.Surface }
    $fg    = if ($isSel) { $c.Accent } else { $c.TextDim }
    $bgBrush = New-Object System.Drawing.SolidBrush($bg)
    $e.Graphics.FillRectangle($bgBrush, $rect)
    if ($isSel) {
        $ab = New-Object System.Drawing.SolidBrush($c.Accent)
        $e.Graphics.FillRectangle($ab, [System.Drawing.Rectangle]::new($rect.X, $rect.Bottom - 3, $rect.Width, 3))
        $ab.Dispose()
    }
    $fmt = New-Object System.Drawing.StringFormat
    $fmt.Alignment     = [System.Drawing.StringAlignment]::Center
    $fmt.LineAlignment = [System.Drawing.StringAlignment]::Center
    $fgBrush = New-Object System.Drawing.SolidBrush($fg)
    $e.Graphics.DrawString($tab.Text, $fSmall, $fgBrush, [System.Drawing.RectangleF]$rect, $fmt)
    $bgBrush.Dispose(); $fgBrush.Dispose()
})

$categories = $tools | Group-Object Category

foreach ($cat in $categories) {
    $tp = New-Object System.Windows.Forms.TabPage
    $tp.Text = $cat.Name; $tp.BackColor = $c.Bg

    $fp = New-Object System.Windows.Forms.FlowLayoutPanel
    $fp.Dock      = "Fill"
    $fp.Padding   = New-Object System.Windows.Forms.Padding(10)
    $fp.AutoScroll = $true
    $fp.BackColor  = $c.Bg
    $tp.Controls.Add($fp)

    foreach ($tool in $cat.Group) {
        # Card
        $card = New-Object System.Windows.Forms.Panel
        $card.Size      = New-Object System.Drawing.Size(268, 66)
        $card.BackColor = $c.Surface
        $card.Margin    = New-Object System.Windows.Forms.Padding(4)
        $card.Cursor    = [System.Windows.Forms.Cursors]::Hand

        # Checkbox (name)
        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Size      = New-Object System.Drawing.Size(248, 20)
        $cb.Location  = New-Object System.Drawing.Point(10, 9)
        $cb.Text      = $tool.Name
        $cb.Font      = $fBold
        $cb.ForeColor = $c.Text
        $cb.BackColor = [System.Drawing.Color]::Transparent
        $cb.Tag       = $tool
        $cb.FlatStyle = "Flat"

        # Description
        $descLbl = New-Object System.Windows.Forms.Label
        $descLbl.Text      = $tool.Desc
        $descLbl.Font      = $fSmall
        $descLbl.ForeColor = $c.TextDim
        $descLbl.Location  = New-Object System.Drawing.Point(28, 32)
        $descLbl.Size      = New-Object System.Drawing.Size(232, 16)
        $descLbl.BackColor = [System.Drawing.Color]::Transparent

        # Colour dot (category indicator)
        $dot = New-Object System.Windows.Forms.Label
        $dot.Size      = New-Object System.Drawing.Size(8, 8)
        $dot.Location  = New-Object System.Drawing.Point(246, 7)
        $dot.BackColor = if ($catColors.ContainsKey($tool.Category)) { $catColors[$tool.Category] } else { $c.TextDim }

        # Capture loop vars for closures
        $localCard      = $card
        $localCb        = $cb
        $checkedBgColor = [System.Drawing.Color]::FromArgb(45, 99, 102, 241)
        $normalBgColor  = $c.Surface
        $hoveredBgColor = $c.Surface2

        $localCard.Add_MouseEnter({ $localCard.BackColor = $hoveredBgColor })
        $localCard.Add_MouseLeave({ $localCard.BackColor = if ($localCb.Checked) { $checkedBgColor } else { $normalBgColor } })
        $localCb.Add_MouseEnter({ $localCard.BackColor = $hoveredBgColor })
        $localCb.Add_MouseLeave({ $localCard.BackColor = if ($localCb.Checked) { $checkedBgColor } else { $normalBgColor } })
        $localCard.Add_Click({ $localCb.Checked = -not $localCb.Checked })

        $localCb.Add_CheckedChanged({
            $cnt = ($checkboxMap.Values | Where-Object { $_.Checked }).Count
            $selCount.Text = "$cnt selected"
            $localCard.BackColor = if ($localCb.Checked) { $checkedBgColor } else { $normalBgColor }
        })

        $localCard.Controls.AddRange(@($localCb, $descLbl, $dot))
        $fp.Controls.Add($localCard)
        $checkboxMap[$tool.ID] = $localCb
    }

    $tabCtrl.TabPages.Add($tp)
}

# ---- RIGHT: Log Panel ----
$rightPanel = New-Object System.Windows.Forms.Panel
$rightPanel.Dock      = "Fill"
$rightPanel.BackColor = $c.Bg
$split.Panel2.Controls.Add($rightPanel)

$logTitle = New-Object System.Windows.Forms.Label
$logTitle.Text      = "  Output Log"
$logTitle.Font      = $fBold
$logTitle.ForeColor = $c.TextDim
$logTitle.Dock      = "Top"
$logTitle.Height    = 28
$logTitle.BackColor = $c.Surface
$logTitle.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
$rightPanel.Controls.Add($logTitle)

$script:logBox = New-Object System.Windows.Forms.RichTextBox
$script:logBox.Dock        = "Fill"
$script:logBox.BackColor   = $c.Bg
$script:logBox.ForeColor   = $c.Text
$script:logBox.Font        = $fMono
$script:logBox.ReadOnly    = $true
$script:logBox.BorderStyle = "None"
$script:logBox.ScrollBars  = "Vertical"
$rightPanel.Controls.Add($script:logBox)

$clearLogBtn = Make-Button "Clear Log" 0 0 0 24 $c.Surface2 $c.TextDim $fSmall
$clearLogBtn.Dock = "Bottom"
$clearLogBtn.Add_Click({ $script:logBox.Clear() })
$rightPanel.Controls.Add($clearLogBtn)

# ---- Bottom Action Bar ----
$bottomBar = New-Object System.Windows.Forms.Panel
$bottomBar.Dock      = "Bottom"
$bottomBar.Height    = 72
$bottomBar.BackColor = $c.Surface
$form.Controls.Add($bottomBar)

$prog = New-Object System.Windows.Forms.ProgressBar
$prog.Location   = New-Object System.Drawing.Point(16, 8)
$prog.Size       = New-Object System.Drawing.Size(1010, 5)
$prog.Style      = "Continuous"
$prog.BackColor  = $c.Surface2
$prog.ForeColor  = $c.Accent
$prog.Anchor     = [System.Windows.Forms.AnchorStyles]::Left -bor
                   [System.Windows.Forms.AnchorStyles]::Right -bor
                   [System.Windows.Forms.AnchorStyles]::Top
$bottomBar.Controls.Add($prog)

$btnSelAll  = Make-Button "Select All"    16  22  100 36 $c.Surface2                                    $c.Text    $fSmall
$btnSelNone = Make-Button "Deselect All"  122 22  100 36 $c.Surface2                                    $c.Text    $fSmall
$btnRun     = Make-Button "Run Selected"  234 22  150 36 $c.Accent                                      $c.Text    $fBold
$btnRec     = Make-Button "Recommended"   392 22  150 36 ([System.Drawing.Color]::FromArgb(30,100,55))  $c.Text    $fBold
$btnUpd     = Make-Button "Self Update"   550 22  130 36 $c.Surface2                                    $c.TextDim $fSmall

$bottomBar.Controls.AddRange(@($btnSelAll, $btnSelNone, $btnRun, $btnRec, $btnUpd))

# ---- Search Logic ----
$searchBox.Add_TextChanged({
    $q = $searchBox.Text.Trim().ToLower()
    if ($q -eq "") {
        foreach ($kv in $checkboxMap.GetEnumerator()) { $kv.Value.Parent.Visible = $true }
        return
    }
    foreach ($kv in $checkboxMap.GetEnumerator()) {
        $t   = $tools | Where-Object { $_.ID -eq $kv.Key }
        $hit = ($t.Name     -like "*$q*") -or
               ($t.Desc     -like "*$q*") -or
               ($t.Tags     -like "*$q*") -or
               ($t.Category -like "*$q*")
        $kv.Value.Parent.Visible = $hit
    }
})

# ---- Select All / None ----
$btnSelAll.Add_Click({
    $checkboxMap.Values | ForEach-Object { $_.Checked = $true }
})
$btnSelNone.Add_Click({
    $checkboxMap.Values | ForEach-Object { $_.Checked = $false }
})

# ---- Run Selected (BackgroundWorker keeps UI responsive) ----
$btnRun.Add_Click({
    $selected = $checkboxMap.Values | Where-Object { $_.Checked }
    if ($selected.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show(
            "Please select at least one tool.", "No Selection", "OK", "Warning") | Out-Null
        return
    }

    $btnRun.Enabled = $false; $btnRec.Enabled = $false
    $selectedTools  = @($selected | ForEach-Object { $_.Tag })

    $worker = New-Object System.ComponentModel.BackgroundWorker
    $worker.WorkerReportsProgress = $true

    $worker.Add_DoWork({
        param($s, $e)
        $tlist = $e.Argument
        $tot   = $tlist.Count
        $i     = 0
        foreach ($t in $tlist) {
            $i++
            $pct = [int](($i - 1) / $tot * 100)
            $s.ReportProgress($pct, "Starting: $($t.Name)")
            try {
                & $t.Action
                $s.ReportProgress([int]($i / $tot * 100), "Done: $($t.Name)")
            } catch {
                $s.ReportProgress(-1, "FAILED: $($t.Name) -- $($_.Exception.Message)")
            }
        }
    })

    $worker.Add_ProgressChanged({
        param($s, $e)
        if ($e.ProgressPercentage -ge 0) {
            $prog.Value = [Math]::Min($e.ProgressPercentage, 100)
            Write-Log $e.UserState $c.Text
        } else {
            Write-Log $e.UserState $c.Red
        }
    })

    $worker.Add_RunWorkerCompleted({
        $prog.Value = 100
        Write-Log "--- All tasks completed ---" $c.Green
        $btnRun.Enabled = $true; $btnRec.Enabled = $true
        [System.Windows.Forms.MessageBox]::Show(
            "All selected tasks completed!", "Done", "OK", "Information") | Out-Null
        $prog.Value = 0
    })

    $worker.RunWorkerAsync($selectedTools)
})

# ---- Recommended Preset ----
$btnRec.Add_Click({
    $recIds = @(4, 5, 9, 10, 12, 13, 15, 24, 25, 29, 34, 28)
    $checkboxMap.Values | ForEach-Object { $_.Checked = $false }
    $recIds | ForEach-Object { if ($checkboxMap.ContainsKey($_)) { $checkboxMap[$_].Checked = $true } }

    $names = ($tools | Where-Object { $recIds -contains $_.ID } | ForEach-Object { "  - $($_.Name)" }) -join "`n"
    $r = [System.Windows.Forms.MessageBox]::Show(
        "The following tools will be installed:`n`n$names`n`nProceed?",
        "Recommended Install", "YesNo", "Question")
    if ($r -eq "Yes") { $btnRun.PerformClick() }
})

# ---- Self Update ----
$btnUpd.Add_Click({
    $url = "https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.ps1"
    Write-Log "Checking for updates from GitHub..." $c.Yellow
    try {
        $content = (Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop).Content
        if ($content.Length -gt 1000) {
            $content | Set-Content $PSCommandPath -Encoding UTF8
            Write-Log "Script updated! Please restart to apply changes." $c.Green
            [System.Windows.Forms.MessageBox]::Show(
                "Script updated! Please restart to apply changes.", "Updated", "OK", "Information") | Out-Null
            $form.Close()
        } else {
            Write-Log "Update content too short - aborted for safety." $c.Yellow
        }
    } catch {
        Write-Log "Update failed: $($_.Exception.Message)" $c.Red
    }
})

# ---- Startup messages ----
Write-Log "Tools Installer v2.0 ready." $c.Accent
Write-Log "Tip: Type in the search box to filter tools by name, category, or tag." $c.TextDim

[void]$form.ShowDialog()
