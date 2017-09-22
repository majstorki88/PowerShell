
#enablovanje rula u firewall-u
Import-Module NetSecurity
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" -Enabled True

#kreiranje novog rula u firewall-u
Import-Module NetSecurity
New-NetFirewallRule -Name Allow_Ping -DisplayName “Allow Ping”  -Description “Packet Internet Groper ICMPv4” -Protocol ICMPv4 -IcmpType 8 -Enabled True -Profile Any -Action Allow

#potrebno je enable-ovati u ICMPv6 tako što se zameni samo broj 4 sa 6

#enable telnet-a na serverima
Import-Module servermanager
Add-WindowsFeature telnet-client

#enable telnet-a na klijentu
pkgmgr /iu:"TelnetClient"

#Setovanje execution polise zbog remote pristupa
Set-ExecutionPolicy RemoteSigned