param (
    [string]$oldPassword = $( Read-Host "Old password"),
    [string]$newPassword = $( Read-Host "New password")
)

$MethodDefinition = @'
[DllImport("netapi32.dll", CharSet = CharSet.Unicode)]
public static extern bool NetUserChangePassword(string domainname, string username, string oldPassword, string newPassword);
'@

$NetAPI32 = Add-Type -MemberDefinition $MethodDefinition -Name 'NetAPI32' -Namespace 'Win32' -PassThru

$NetAPI32::NetUserChangePassword('.', $env:username, $oldPassword, $newPassword)