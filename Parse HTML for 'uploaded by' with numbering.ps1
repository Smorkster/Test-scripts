<#
.SYNOPSIS
	Parse an HTML-file to get the 'uploaded by' from YouTube HTML
.DESCRIPTION
	In the given HTML-file are a section of HTML extracted from a YouTube-users list of all videos.
	This script takes the HTML-file, reads the data and writes a list to specified file.
#>

$fileToRead = Read-Host -Prompt "File to read"
$fileToWrite = Read-Host -Prompt "File to write"
$a = Get-Content $fileToRead
$ticker = 1
$ticker2 =  [int]($a.Count/4)
$list = New-Object System.Collections.ArrayList
foreach($i in $a)
{
	if($ticker -eq 4)
	{
        $s = $ticker2.ToString() + " " + $i
		$list.Add($s) > $null
		$ticker = 1
        $ticker2 = $ticker2 - 1
	} else {
		$ticker = $ticker + 1
	}
}

$list > $fileToWrite