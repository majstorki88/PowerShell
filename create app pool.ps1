#rad na udaljenom serveru

Invoke-Command -ComputerName "ime servera" -ScriptBlock { 

#u slucaju da se radi direktno na serveru sa IIS-ob, krece se odavde io brise se poslednja zagrada
Import-Module WebAdministration
$iisAppPoolName = "ime-app-pool-a"
$iisAppPoolDotNetVersion = "v4.0"
$iisAppName = "ime-test-app.test"
$directoryPath = "C:\pool"
if (!(Test-Path $iisAppPoolName -pathType container))
{
    #kreiranje pool-a
    $appPool = New-Item $iisAppPoolName
    $appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
}

#site root lokacija
cd IIS:\Sites\

#provera da li sajt postoji
if (Test-Path $iisAppName -pathType container)
{
    return
}

#kreiranje sajta
$iisApp = New-Item $iisAppName -bindings @{protocol="http";bindingInformation=":80:" + $iisAppName} -physicalPath $directoryPath
$iisApp | Set-ItemProperty -Name "applicationPool" -Value $iisAppPoolName
}