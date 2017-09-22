[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    $kredencijali= (Get-Credential -Message "otkucaj username i password")
    [Parameter(Mandatory=$True)]
    [string]$server,
    [Parameter(Mandatory=$True)]
    [string]$folder,
    [Parameter(Mandatory=$True)]
    [string]$ImeShare,
    [Parameter(Mandatory=$True)]
    [string[]]$userSaFullPravima
    [Parameter(Mandatory=$True)]
    [string[]]$usersaChangePravima
    [Parameter(Mandatory=$True)]
    [string[]]$userSaReadPravima
)
#kreiranje foldera za sherovanje 
#NAPOMENA: FOLDER SE MORA UNETI SA PUTANJOM! 
#ako zelimo kreirati folder munja na lokaciji C:, za folder se unosi C:\munja!!!
Invoke-Command -ComputerName $server -Credential $kredencijali -ScriptBlock {New-Item “$folder" –type directory}

#kreiranje share sa dozvolama
Invoke-Command -ComputerName $server -Credential $kredencijali -ScriptBlock {New-SMBShare –Name “$ImeShare” –Path “$folder” –ContinuouslyAvailable –FullAccess $userSaFullPravima -ChangeAccess $usersaChangePravima -ReadAccess $userSaReadPravima }