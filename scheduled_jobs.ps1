[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]$ime_servera,
    $kredencijali= (Get-Credential -Message "otkucaj username i password")
)
Invoke-Command -ComputerName $ime_servera -Credential $kredencijali -ScriptBlock {Get-ScheduledTask -TaskName * -TaskPath \Microsoft\Windows\* }