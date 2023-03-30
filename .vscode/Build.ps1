# Vars
. ".vscode\Global.ps1 "

# intunewin
[String]$Uri = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool"
[String]$Exe = "IntuneWinAppUtil.exe"

# Source content prep tool
if (-not(Test-Path -Path "$env:ProgramData\$Exe")){
    Invoke-WebRequest -Url "$Uri/$Exe" -OutFile "$env:ProgramData\$Exe"
}

# Execute content prep tool
$processOptions = @{
    FilePath = "$env:ProgramData\$Exe"
    ArgumentList = "-c ""$Cache"" -s ""$Cache\Deploy-Application.exe"" -o ""$env:TEMP"" -q"
    WindowStyle = "Maximized"
    Wait = $true
}
Start-Process @processOptions

# Rename and prepare for upload
Move-Item -Path "$env:TEMP\Deploy-Application.intunewin" -Destination "$Documents\$Application.intunewin" -Force -Verbose explorer $Desktop
