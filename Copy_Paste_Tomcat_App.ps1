
# 0 - Promenljiva u kojoj stoji adresa odakle se vrsi deploy.
$cela_adresa = "\\server\adressa_deploya";		# Ovde se menja adresa po potrebi.
$computers = servers.txt
$service = "ime_tomcat"
&putanja = "D:\folder"
&backup = "\\$computers\D$\backup"
$putanja_za_backup = "\\$computers\D$\app"


# 1 - Stopiranje Apache servisa na serverima.
Invoke-Command -ComputerName $computers -ScriptBlock {Stop-Service -Name $service};	# Ime kako ga vidi PowerShell.

 while  (-not((Get-Service -ComputerName $computers -Name $service | Where-Object {$_.status -eq "Stopped"})))
        {
        Start-Sleep -Milliseconds 200
        }
Start-Sleep -Seconds 5;   # Malo da saceka.

# 2 - Brisanje sadrzaja foldera sa podfolderima.
Invoke-Command -ComputerName $computers -ScriptBlock {Get-ChildItem -Path '"$putanja"' | Remove-Item} -Force;

# 3 - Kreiranje folder sa datumom u nazivu da bismo u njega izvrsili bekap.
$datum = (Get-Date -Format yyyyMMdd);
Invoke-Command {New-Item "$backup" -type directory -Force};

Copy-Item "$putanja_za_backup\*" -Destination "\\$computers\D$\backup\$datum\app" -Force;

# 4 - Startovanje Apache servisa na serverima kadocjakia1/2/3 (IZBACENI KREDENCIJALI)
Invoke-Command -ComputerName $computers -ScriptBlock {Start-Service -Name $service};	# Ime kako ga vidi PowerShell.

# 5 - cekanje i testpath - stari deo koda.
while (-not (Test-Path #putanja_do_tomcata))
{
   Start-Sleep -Milliseconds 60
};

# 6 - kopiranje ostalih fajlova.
Copy-Item "\\$cela_adresa\fajl.txt" -Destination "$destinacija" -Force;
