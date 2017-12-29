<#
.SYNOPSIS
	Read a local HTML-file to extract webaddresses for YouTube-videos
#>

$fileToRead
$a = (Get-Content $fileToRead | ? {$_ -match "href"} | ? {$_ -match "watch"} | ? {$_ -notmatch "thumbnail"})
$b = $a[0]
<#foreach($i in $a)
{
    Write-host $i.Substring($i.indexof("href=")+"href=".Length+1,$i.indexof("&amp"))
}#>
Write-Host $b.IndexOf("&amp")
Write-Host $b.Substring($b.indexof("href=")+"href=".Length+1, $b.indexof("&amp")-$b.IndexOf("href=")-1)