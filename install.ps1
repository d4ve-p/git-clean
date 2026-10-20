# PowerShell installer for git-clean
[CmdletBinding()]
param(
    [string]$TargetDir = "$HOME\.local\bin"
)

$ErrorActionPreference = "Stop"
$ScriptDir = $PSScriptRoot

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

Copy-Item -Path "$ScriptDir\git-clean" -Destination "$TargetDir\git-clean" -Force
Copy-Item -Path "$ScriptDir\git-clean.cmd" -Destination "$TargetDir\git-clean.cmd" -Force

Write-Host "[OK] git-clean installed successfully to: $TargetDir" -ForegroundColor Green

$envPaths = [Environment]::GetEnvironmentVariable("Path", "User") -split ";"
$allPaths = $env:PATH -split ";"

if (($envPaths -notcontains $TargetDir) -and ($allPaths -notcontains $TargetDir)) {
    Write-Host ""
    Write-Host "Notice: $TargetDir is not in your PATH." -ForegroundColor Yellow
    Write-Host "To add it to your user PATH, run:"
    Write-Host '[Environment]::SetEnvironmentVariable("Path", $env:Path + ";' + $TargetDir + '", "User")'
} else {
    Write-Host "You can now run 'git-clean .' in any git repository!" -ForegroundColor Cyan
}
