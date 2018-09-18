# Run this as a non-administrative user.
# From https://discourse.chef.io/t/chef-dk-on-windows-administrative-rights-required/12499/3

$envPath = Resolve-Path "$PSScriptRoot/.."
[System.Environment]::SetEnvironmentVariable('CHEF_REPO_PATH', $envPath, 'user')

$profileContent = @'
function bal { 
	push-location $env:CHEF_REPO_PATH
	berks update
	Get-ChildItem "environments/*.json" | ForEach-Object{ berks apply $_.Name.Split('.')[0] --envfile $_.FullName }
	pop-location
}

Set-Alias berks-apply-local bal

# Set knife-env alias
function ke {
    param( [string]$filter = '*')
    push-location $env:CHEF_REPO_PATH
    Get-ChildItem "environments/*.json" -Filter $filter | ForEach-Object { knife environment from file $_.FullName }
    pop-location
}

Set-Alias knife-env ke

function ku {
    param( [string]$cookbook = (Get-Item .).Name )
    push-location $env:CHEF_REPO_PATH
    knife cookbook site share $cookbook -u delivery -k ../.chef/delivery.pem
    knife cookbook upload $cookbook -u delivery -k ../.chef/delivery.pem
    pop-location
}

Set-Alias knife-upload ku


function edi {
    param( 
        [Parameter(Mandatory=$true, Position = 0)]
        [ValidateSet('create', 'edit', 'show')]
        [string]$Command,
        [Parameter(Mandatory=$true, Position = 1)]
        [string]$Databag,
        [Parameter(Mandatory=$true, Position = 2)]
        [string]$DatabagItem,
        [Parameter(Mandatory=$true, Position = 3)]
        [ValidateSet('us', 'gb', 'jp')]
        [string]$Region,
        [Parameter(Mandatory=$false, Position = 4)]
        [ValidateSet('dev', 'prod')]
        [string]$EnvironmentKey = 'dev'
    )
    push-location $env:CHEF_REPO_PATH
    knife data bag $Command $Databag $DatabagItem --secret-file "../.chef/encrypted_data_bag_secret_$Region_$Environment"
    pop-location
}

Set-Alias encrypted-data-bag-item edi

# Set TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Set berks-apply-local alias
function bal { 
	push-location $env:CHEF_REPO_PATH
	berks update
	Get-ChildItem "environments/*.json" | %{ berks apply $_.Name.Split('.')[0] --envfile $_.FullName }
	pop-location
}

Set-Alias berks-apply-local bal

# Set knife-env alias
function ke {
    param( [string]$filter = '*')
    push-location $env:CHEF_REPO_PATH
    Get-ChildItem "environments/*.json" -Filter $filter | ForEach-Object { knife environment from file $_.FullName }
    pop-location
}

Set-Alias knife-env ke

# Ensures Console is readable.
$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')
$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'DarkBlue')
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.PrivateData.ErrorForegroundColor = 'Red'
$Host.PrivateData.ErrorBackgroundColor = $bckgrnd
$Host.PrivateData.WarningForegroundColor = 'Magenta'
$Host.PrivateData.WarningBackgroundColor = $bckgrnd
$Host.PrivateData.DebugForegroundColor = 'Yellow'
$Host.PrivateData.DebugBackgroundColor = $bckgrnd
$Host.PrivateData.VerboseForegroundColor = 'Green'
$Host.PrivateData.VerboseBackgroundColor = $bckgrnd
$Host.PrivateData.ProgressForegroundColor = 'Cyan'
$Host.PrivateData.ProgressBackgroundColor = $bckgrnd
Clear-Host
'@

$profileContent | Out-File -Force -Encoding utf8 $PROFILE

