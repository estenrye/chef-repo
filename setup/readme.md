# Development Environment Setup Scripts

This folder contains scripts that make my development environment function properly.

| Script Name | Arguments | Run as Admin | Purpose or Description |
| Initialize-Path.ps1 | None | Yes | This script adds the Git binaries to the machine's PATH variable.  This allows the developer to use ssh without the need for Putty or Git Bash. |
| Initialize-Profile.ps1 | None | No | This script adds the Chef-DK package to the developer's profile so he or she can execute chef tools without needing to be in an administrative powershell prompt. |
| Get-Packer.ps1 | `-version` | No | Downloads specified version of packer if not already downloaded. |
| Configure-Git.ps1 | None | No | Sets preferred settings for git. |
| Build-Image.ps1 | None | No | Builds vagrant box image in standardized location. |