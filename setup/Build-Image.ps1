Push-Location "$PSScriptRoot/../packer"
../bin/packer.exe build hyperv-ubuntu-16.04.json
$hash =  Get-FileHash -Algorithm sha256 .\hyperv_ubuntu-16.04_chef.box
vagrant.exe box add --checksum $hash.Hash --checksum-type $hash.Algorithm.ToLower() --provider hyperv --name 'estenrye/ubuntu-16.04' --force $hash.Path
Pop-Location