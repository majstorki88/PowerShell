[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    $kredencijali= (Get-Credential -Message "otkucaj username i password"),
    [Parameter(Mandatory=$True)]
    [string[]]$server
)

$psstats = Get-Counter -ComputerName $server '\Process(*)\% Processor Time' -ErrorAction SilentlyContinue `
    |Select-Object -ExpandProperty countersamples | %{New-Object PSObject -Property @{ComputerName=$_.Path.Split('\')[2];Process=$_.instancename;CPUPct=("{0,4:N0}%" -f $_.Cookedvalue);CookedValue=$_.CookedValue}} | ?{$_.CookedValue -gt 0}`
    |Sort-Object @{E='ComputerName'; A=$true },@{E='CookedValue'; D=$true },@{E='Process'; A=$true }

$psstats | ft @{E={"{0,25}" -f $_.Process};L="ProcessName"},CPUPct -AutoSize -GroupBy ComputerName -HideTableHeaders


Get-Counter -ComputerName $server -Get-Credential $kredencijali '\Process(*)\% Processor Time' `
    | Select-Object -ExpandProperty countersamples `
    | Select-Object -Property instancename, cookedvalue `
    | Sort-Object -Property cookedvalue -Descending | Select-Object -First 20 `
    | ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100).toString('P')}} -AutoSize
