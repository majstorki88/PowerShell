Invoke-Command -ComputerName web -ScriptBlock {
#instalacija nove role sa svim featerima
import-module servermanager
add-windowsfeature web-server -includeallsubfeature
}
#sa specijalnim featerima
import-module servermanager
add-windowsfeature Web-Server, Web-WebServer, Web-Security, 
Web-Filtering