function ChangePassword(){
param (
    [string]$oldPassword = $( Read-Host "Insert your old password"),
    [string]$newPassword = $( Read-Host "Insert your new password")
)

$ADSystemInfo = New-Object -ComObject ADSystemInfo
$type = $ADSystemInfo.GetType()
$user = [ADSI] "LDAP://$($type.InvokeMember('UserName', 'GetProperty', $null, $ADSystemInfo, $null))"
$user.ChangePassword( $oldPassword, $newPassword)
}

ChangeAPassword

Write-Host "Press any key to continue..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
