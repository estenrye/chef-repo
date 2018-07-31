# Run this as a non-administrative user.
# From https://discourse.chef.io/t/chef-dk-on-windows-administrative-rights-required/12499/3
$profileContent = @'
chef shell-init powershell | iex 
import-module chef -DisableNameChecking

# Set TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
'@

$profileContent | Out-File -Append -Force -Encoding utf8 $PROFILE

