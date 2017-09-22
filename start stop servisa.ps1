[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    $kredencijali= (Get-Credential -Message "otkucaj username i password")
    [Parameter(Mandatory=$True)]
    [string]$server,
    [Parameter(Mandatory=$True)]
    [string]$servis,
    [Parameter(Mandatory=$True)]
    [string]$user
)

#dodeljivanje prava useru na start/stop servisa
Invoke-Command -ComputerName $server -Credential $kredencijali -ScriptBlock {subinacl.exe /service $servis /GRANT=$user=STOE}


# prava na servise:
#    F : Full Control  
#    R : Generic Read  
#    W : Generic Write  
#    X : Generic eXecute  
#    or any following values  
#    L : Read controL  
#    Q : Query Service Configuration  
#    S : Query Service Status  
#    E : Enumerate Dependent Services  
#    C : Service Change Configuration  
#    T : Start Service  
#    O : Stop Service  
#   P : Pause/Continue Service  
#    I : Interrogate Service  
#    U : Service User-Defined Control Commands  