
$PUTANJA = '\\IMESERVERA\Shared_Location\'
$EXPORT1 = "D:\Logs\error1.txt"   #PUTANJA DO EXPORTA
$EXPORT1 = "D:\Logs\error2.txt"
$SENDER  = "error@google.com"
$RECEIVER = "nemanja@google.com"

$N = Select-String "$PUTANJA\_$(get-date -f yyyy-MM-dd)*.log" -pattern " ERROR "  -AllMatches
if ( $N.length -lt 1) {
	echo "Sve je OK"
	exit
else {echo "Ima gresaka"
	Select-String "$PUTANJA\_$(get-date -f yyyy-MM-dd)*.log" -pattern " ERROR " >> $EXPORT
	$TIME = get-date -f HH
	$TIME = "T" + $TIME + ":"
	$CHECK = Select-String $EXPORT -pattern $TIME
	else { echo "NEW LOGS"
		Select-String $EXPORT -pattern $TIME > $EXPORT2
		Send-MailMessage -To "$RECEIVER" -Subject "ERROR: Notification  from server" -Body "Error" -SmtpServer "SMTP server" -From "$SENDER" -attachments $EXPORT2
}
}
}
