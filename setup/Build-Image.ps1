Push-Location "$PSScriptRoot/../packer"
../bin/packer.exe build hyperv-ubuntu-16.04.json
Pop-Location