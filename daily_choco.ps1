# Windows Daily Software Upgrade
param([switch]$Elevated)

$Today = Get-Date -Format 'dd/MM/yyyy'
$DateFile = $PSScriptRoot + "\log\date.log"
$LogFile = $PSScriptRoot + "\log\daily-choco-update.log"

if (!(Test-Path $DateFile))
{
   New-Item -path $DateFile -type "file"
   Write-Host "Created date file"
}

# Check if the script worked today
if ((Get-Content -Path $DateFile) -match $Today) {
	Write-Host "This script worked today already"
	Start-Sleep -Seconds 2
	Kill $PID
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

'Running with full privileges'

Start-Transcript -path $LogFile -append

choco upgrade all -y
Write-Host ""
conda update --all -y
refreshenv
$Today | Out-File -FilePath $DateFile
Stop-Transcript

Start-Sleep -Seconds 10
Kill $PID
