param(
    [switch]$InstallGit,
    [switch]$InstallNode,
    [switch]$InstallVSCode,
    [switch]$InstallChrome,
    [switch]$InstallMongoDB,
    [switch]$InstallMongoSH,
    [switch]$InstallNpmGlobals,
    [switch]$InstallNpmFrameworks,
    [switch]$InstallVSCodeExts
)

# -------------------------------------------------------------------
# Configuration for Robustness and Logging
# -------------------------------------------------------------------

$ErrorActionPreference = 'Stop'
$LogDirectory = "$env:PUBLIC\Document"
if (-not (Test-Path -Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
}
$LogFile = Join-Path -Path $LogDirectory -ChildPath "js-dev-env-setup-log-$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').txt"
Start-Transcript -Path $LogFile

Write-Host "Script execution started. A detailed log is being saved to: $LogFile"

# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------

function Run-Command {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Command,

        [Parameter(Mandatory=$true)]
        [string]$Args
    )
    Write-Host "Running: $Command $Args"
    $proc = Start-Process -FilePath $Command -ArgumentList $Args -Wait -NoNewWindow -PassThru
    if ($proc.ExitCode -ne 0) {
        Throw "$Command failed with exit code $($proc.ExitCode)"
    }
}

function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey package manager..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    } else {
        Write-Host "Chocolatey is already installed."
    }
}

# -------------------------------------------------------------------
# Installation Logic (Using multi-line if blocks and named parameters for clarity and robustness)
# -------------------------------------------------------------------

if ($InstallGit) {
    Write-Host "Ensuring Git is up-to-date..."
    Install-Chocolatey
    Run-Command -Command "choco" -Args "upgrade git -y"
}
if ($InstallNode) {
    Write-Host "Ensuring Node.js LTS is up-to-date..."
    Install-Chocolatey
    Run-Command -Command "choco" -Args "upgrade nodejs-lts -y"
}
if ($InstallVSCode) {
    Write-Host "Ensuring Visual Studio Code is up-to-date..."
    Install-Chocolatey
    Run-Command -Command "choco" -Args "upgrade vscode -y"
}
if ($InstallChrome) {
    Write-Host "Ensuring Google Chrome is up-to-date..."
    Install-Chocolatey
    Run-Command -Command "choco" -Args "upgrade googlechrome -y"
}
if ($InstallMongoDB) {
    Write-Host "Ensuring MongoDB is up-to-date..."
    Install-Chocolatey
    Run-Command -Command "choco" -Args "upgrade mongodb -y"
}
if ($InstallMongoSH) {
    Write-Host "Ensuring Mongo Shell (mongosh) is up-to-date..."
    Install-Chocolatey
    Run-Command -Command "choco" -Args "upgrade mongodb-shell -y"
}

if ($InstallNpmGlobals) {
    Write-Host "Ensuring global npm packages are up-to-date..."
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        npm install -g eslint prettier typescript nodemon
    } else {
        Write-Warning "npm not found! Ensure Node.js is installed."
    }
}

if ($InstallNpmFrameworks) {
    Write-Host "Ensuring global JS frameworks are up-to-date..."
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        npm install -g create-react-app next express
    } else {
        Write-Warning "npm not found! Ensure Node.js is installed."
    }
}

if ($InstallVSCodeExts) {
    Write-Host "Ensuring VSCode extensions are up-to-date..."
    $vscodeCmd = "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd"
    if (Test-Path $vscodeCmd) {
        & $vscodeCmd --install-extension dbaeumer.vscode-eslint
        & $vscodeCmd --install-extension esbenp.prettier-vscode
        & $vscodeCmd --install-extension christian-kohler.npm-intellisense
    } else {
        Write-Warning "VSCode command-line tool not found! Ensure VSCode is installed."
    }
}

# -------------------------------------------------------------------
# Finalization
# -------------------------------------------------------------------

Write-Host "Installation script completed successfully."
Write-Host "A log file for this session has been saved to the Public Desktop: $LogFile"

# Stop the transcript to finalize the log file
Stop-Transcript

exit 0