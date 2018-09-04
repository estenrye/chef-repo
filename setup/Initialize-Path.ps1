# From http://www.hurryupandwait.io/blog/need-an-ssh-client-on-windows-dont-use-putty-or-cygwinuse-git
if (-not $env:PATH.Contains('C:/Program Files/Git/usr/bin'))
{
    $new_path = "$env:PATH;C:/Program Files/Git/usr/bin"
    $env:PATH=$new_path
    [Environment]::SetEnvironmentVariable("path", $new_path, "user")
}