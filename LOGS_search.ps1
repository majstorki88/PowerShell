
$PUTANJA = "putanja_do_loga";
$PROVERA = Get-Content $PUTANJA -Tail 10000;
$TIME =(get-date).AddMinutes(-1).ToString(" HH:mm");
$GRESKA1 = "(\d{4}-\d{2}-\d{2}${TIME}:\d{2},\d{3} ERROR)(.+?)(\d{4}-\d{2}-\d{2} \d{2}:\d{2})";
$GRESKA2 = "(\d{4}-\d{2}-\d{2}${TIME}.+?drugui_string)(.+?)(\d{4}-\d{2}-\d{2} \d{2}:\d{2})";
$GRESKA3 = "(\d{4}-\d{2}-\d{2}${TIME}.+?treci_string)(.+?)(\d{4}-\d{2}-\d{2} \d{2}:\d{2})";
$CHECK1 = [regex]::matches($PROVERA,$GRESKA1) | foreach {$_.groups[0].value;'***'};
$CHECK2 = [regex]::matches($PROVERA,$GRESKA2) | foreach {$_.groups[0].value;'***'};
$CHECK3 = [regex]::matches($PROVERA,$GRESKA3) | foreach {$_.groups[0].value;'***'};
if (($CHECK1.length -lt 1) -and ($CHECK2.length -lt 1) -and ($CHECK3.length -lt 1))  {
  Write-Host "Sve je OK"}
else {Write-Host "Ima gresaka";
$CHECK1 >> D:\error.txt;
$CHECK2 >> D:\error.txt;
$CHECK3 >> D:\error.txt;
Send-MailMessage -To "receiver@gmail.com" -Subject "ERROR" -Body "Error Notification  from " -SmtpServer "smtp.telekom.rs" -From "error@gmail.com" -attachments "D:\error.txt"
Remove-Item -Path D:\error.txt -Force;}
