$video = Read-Host "YouTube-videoID"
$YouTube_APIKey = Read-Host "API-key for YouTube"
$gdata_uri = "https://www.googleapis.com/youtube/v3/videos?id=$video&key=$youtube_apikey&part=contentDetails"
$metadata = irm $gdata_uri
$duration = $metadata.items.contentDetails.duration

$ts = [Xml.XmlConvert]::ToTimeSpan($duration)
Write-Host $ts
