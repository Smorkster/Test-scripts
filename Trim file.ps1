<#
.SYNOPSIS
	Read a file and trim all lines of starting and trailing white spaces
#>

$f = Read-Host "File"
$lines=(Get-Content $f) | foreach{ $_.Trim()}  
$lines > $f