$char = Read-Host "Charactername"
$realm = Read-Host "Realm"
$answer = Invoke-WebRequest -Uri "https://raider.io/api/v1/characters/profile?region=eu&realm=$realm&name=$char&fields=mythic_plus_scores%2Cmythic_plus_highest_level_runs" | ConvertFrom-Json
$answer.mythic_plus_highest_level_runs[0].mythic_level
$answer.mythic_plus_scores.all