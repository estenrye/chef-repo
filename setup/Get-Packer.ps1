param(
    [string]$version = '1.2.4'
)
$binPath = "$PSScriptRoot/../bin"

if (-not (Test-Path $binPath))
{
    New-Item -ItemType Directory $binPath
} 

$currentVersion = $null
if (Test-Path "$binPath/packer.exe") 
{
    $currentVersion = (&"$binPath/packer.exe" -v)
}

if (-not (Test-Path "$binPath/packer.exe") -or ($version -ne $currentVersion))
{
    Invoke-WebRequest `
        -UseBasicParsing `
        "https://releases.hashicorp.com/packer/$($version)/packer_$($version)_windows_amd64.zip" `
        -OutFile "$binPath/packer.zip"
    
    Expand-Archive -Path "$binPath/packer.zip" -DestinationPath $binPath
    Remove-Item -Force "$binPath/packer.zip"
}