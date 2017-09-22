$computer = C:\server.txt #ime račuinara
$servis1 = "*ime-servisa1*"
$servis2 = "*ime-servisa2*"
$servis3 = "*ime-servisa3*"
$LOG_LOCATION = "\\$computer\logs\server.log"
$LOG_PARCE = "D:\logs\start.log"

invoke-command -computername $computer -scriptblock {Get-Service | Where-Object {$_.Status -eq "Stopped"} | Where-Object {$_.Name -like $servis1} | Start-Service};
Start-Sleep -s 60;
invoke-command -computername $computer -scriptblock {Get-Service | Where-Object {$_.Status -eq "Stopped"} | Where-Object {$_.Name -like $servis2} | Start-Service};
Select-String "$LOG_LOCATION" -pattern "Server startup" -AllMatches >> $LOG_PARCE;
$TIME = (get-date).AddMinutes(-5).ToString("yyyy-MM-dd HH:mm");
$CHECK = Select-String $LOG_PARCE -pattern $TIME;
do
{
Select-String "$LOG_LOCATION" -pattern "Server startup" -AllMatches >> $LOG_PARCE;
$TIME = (get-date).AddMinutes(-1).ToString("yyyy-MM-dd HH:mm");
$CHECK = Select-String $LOG_PARCE -pattern $TIME;
Start-Sleep -s 20;
}while ($CHECK.length -lt 1);
Remove-Item $LOG_PARCE -Force;

invoke-command -computername $computer -scriptblock {Get-Service | Where-Object {$_.Status -eq "Stopped"} | Where-Object {$_.Name -like $servis3} | Start-Service};
