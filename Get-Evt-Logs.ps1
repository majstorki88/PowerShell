$start = '8/16/2017'
$end = '8/17/2017'

function GetMilliseconds ($date) {
    $ts = New-TimeSpan -Start $date -End (Get-Date)
    [math]::Round($ts.TotalMilliseconds)
    } # end function

$startDate = GetMilliseconds(Get-Date $start)
$endDate = GetMilliseconds(Get-Date $end)

wevtutil epl Application $lokacija\log.evtx /q:"*[System[TimeCreated[timediff(@SystemTime) >= $endDate] and TimeCreated[timediff(@SystemTime) <= $startDate]]]" /overwrite:trues | ForEach-Object -Process {Invoke-Command -ComputerName $_ -ScriptBlock {wevtutil epl System \\$comp\C$\logovi\$_.evtx}
