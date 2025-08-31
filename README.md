# **Tools Installer**

A Windows batch script with an interactive menu to quickly install developer tools and run automation scripts. This script simplifies the setup of essential development tools and automation utilities on Windows systems.

## **Run in PowerShell**
```
irm "https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.cmd" -OutFile tools-installer.cmd; Start-Process tools-installer.cmd
```

## **Features**

*   **Interactive Menu**: Choose from a list of options to install tools or run scripts.
*   **Developer Tools**: Install Node.js LTS, Python, Git, Chocolatey, n8n, Gemini CLI, and Qwen CLI.
*   **Automation Scripts**: Run Chris Titus Tool, MassGrave, and Coporton scripts.
*   **PowerShell Management**: View or unrestrict PowerShell execution policies.
*   **Flexible Execution**: Run all tools/scripts in sequence or select specific ones to execute.

## **Menu Options**

1.  **See Policy**: Displays the current PowerShell execution policy.
2.  **Unrestrict Policy**: Sets PowerShell execution policy to Unrestricted.
3.  **Install Chocolatey**: Installs the Chocolatey package manager.
4.  **Install Node.js LTS**: Installs the Long-Term Support version of Node.js.
5.  **Run Chris Titus Tool**: Executes the Chris Titus Windows optimization script.
6.  **Run Mass Grave**: Runs the MassGrave Windows activation script.
7.  **Run Coporton**: Executes the Coporton automation script.
8.  **Install Python**: Installs the latest version of Python.
9.  **Install Git**: Installs Git for version control.
10.  **Install n8n**: Installs n8n automation tool (run `n8n` in cmd to start).
11.  **Install Gemini CLI**: Installs Google's Gemini CLI (run `gemini` in cmd to start).
12.  **Install Qwen CLI**: Installs Qwen CLI (run `qwen` in cmd to start).
13.  **Run All**: Executes all options in sequence.
14.  **Run Selected**: Allows running specific options by entering their numbers (e.g., `1,3,5`).
15.  **Exit**: Closes the script.

## **Prerequisites**

*   Windows operating system.
*   Administrative privileges to run the script and install tools.
*   Internet connection for downloading tools and scripts.

## **Usage**

1.  Download the `tools-installer.bat` script from the [GitHub repository](https://github.com/afnan-nex/tools-installer).
2.  Right-click the script and select **Run as Administrator**.
3.  Use the interactive menu to select options by entering numbers (1-15).
4.  Follow on-screen prompts to install tools or run scripts.
5.  For CLI tools (n8n, Gemini CLI, Qwen CLI), run their respective commands in the command prompt after installation.

## **Installation Notes**

*   **Chocolatey**: Required for installing Node.js, Python, and Git. Ensure option 3 is run before options 4, 8, or 9 if Chocolatey is not already installed.
*   **PowerShell Policy**: Options 1 and 2 help manage PowerShell execution policies, which may be required for some scripts.
*   **CLI Tools**: After installing n8n, Gemini CLI, or Qwen CLI, open a new command prompt and type their respective commands (`n8n`, `gemini`, `qwen`) to use them.

## **License**

This project is licensed under the MIT License. See the [LICENSE](https://github.com/afnan-nex/tools-installer/blob/main/LICENSE) file for details.

## **Author**

Created by Afnan Siddiqui. Follow me on Instagram: [@afnan-nex](https://instagram.com/afnan-nex).

## **Disclaimer**

This script downloads and executes third-party tools and scripts. Use at your own risk. Ensure you understand the purpose of each tool/script before running. The author is not responsible for any damages or issues caused by the use of this script.
