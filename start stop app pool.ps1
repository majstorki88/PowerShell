
# prvi nacin
Invoke-Command -ComputerName "REMOTE_SERVER" -ScriptBlock {Import-Module WebAdministration Start-WebAppPool -Name "MY_FANCY_APPPOOL" }
Invoke-Command -ComputerName "REMOTE_SERVER" -ScriptBlock {Import-Module WebAdministration Stop-WebAppPool -Name "MY_FANCY_APPPOOL" }

#drugi nacin

$pc = "ServerName" 
 
## lista app pool-ove na serverima, obratiti paynju na trazeni __RELPATH 
Get-WmiObject IISApplicationPool -ComputerName $pc -Namespace root\MicrosoftIISv2

## restartovati odredjeni: 
$Name = "W3SVC/APPPOOLS/TESTApplicationPoolName"  ## dobijeno ime iz liste 
$Path = "IISApplicationPool.Name='$Name'"      ## __RELPATH 
 
Invoke-WMIMethod Recycle -Path $Path -Computer $pc -Namespace root\MicrosoftIISv2
