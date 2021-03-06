
Function Copy-FileToRemote {
 
<#
.Synopsis
Copy a file over a PSSession.
.Description
This command can be used to copy files to remote computers using PowerShell remoting. Instead of traditional file copying, this command copies files over a PSSession. You can copy the same file or files to multiple computers simultaneously. Existing files will be overwritten.

NOTE: The file size cannot exceed 10MB. Files larger than 10MB will throw an exception and not be copied.
.Parameter Path
The path to the local file to be copied. The file size cannot exceed 10MB.
.Parameter Destination
The folder path on the remote computer. The path must already exist.
.Parameter Computername
The name of remote computer. It must have PowerShell remoting enabled.
.Parameter Credential
Credentials to use for the remote connection.
.Parameter Passthru
By default this command does not write anything to the pipeline unless you use -passthru.

.Example
PS C:\> dir C:\data\mydata.xml | copy-filetoremote -destination c:\files -Computername SERVER01 -passthru


    Directory: C:\files


Mode                LastWriteTime     Length Name                        PSComputerName
----                -------------     ------ ----                        --------------
-a---        10/17/2014   7:51 AM    3126008 mydata.xml                        SERVER01

Copy the local file C:\data\mydata.xml to C:\Files\mydata.xml on SERVER01.

.Example
PS C:\> dir c:\data\*.* | Copy-FileToRemote -destination C:\Data -computername (Get-Content c:\work\computers.txt) -passthru

Copy all files from C:\Data locally to the directory C:\Data on all of the computers listed in the text file computers.txt. Results will be written to the pipeline.
.Notes
Last Updated: October 17,2014
Version     : 1.0

Learn more:
 PowerShell in Depth: An Administrator's Guide (http://www.manning.com/jones6/)
 PowerShell Deep Dives (http://manning.com/hicks/)
 Learn PowerShell in a Month of Lunches (http://manning.com/jones3/)
 Learn PowerShell Toolmaking in a Month of Lunches (http://manning.com/jones4/)

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************

.Link
Copy-Item
New-PSSession
#>

[CmdletBinding(DefaultParameterSetName='Path', SupportsShouldProcess=$true)]
 param(
     [Parameter(ParameterSetName='Path', Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
     [Alias('PSPath')]
     [string[]]$Path,
     [Parameter(Position=1, Mandatory=$True,
     HelpMessage = "Enter the remote folder path",ValueFromPipelineByPropertyName=$true)]
     [string]$Destination,
     [Parameter(Mandatory=$True,HelpMessage="Enter the name of a remote computer")]
     [string[]]$Computername,
          [pscredential][System.Management.Automation.CredentialAttribute()]$Credential=[pscredential]::Empty,
     [Switch]$Passthru
     )

     Begin {
         Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
         Write-Verbose "Bound parameters"
         Write-Verbose ($PSBoundParameters | Out-String)
         Write-Verbose "WhatifPreference = $WhatIfPreference"
         #create PSSession to remote computer
         Write-Verbose "Creating PSSessions"
         $myRemoteSessions = New-PSSession -ComputerName $Computername -Credential $credential

         #validate destination
         Write-Verbose "Validating destination path $destination on remote computers"
         foreach ($sess in $myRemoteSessions) {
           if (Invoke-Command {-not (Test-Path $using:destination)} -session $sess) {
             Write-Warning "Failed to verify $destination on $($sess.ComputerName)"
             #always remove the session
             $sess | Remove-PSSession -WhatIf:$False
           }

         }

         #remove closed sessions from variable
         $myRemoteSessions = $myRemoteSessions | where {$_.state -eq 'Opened'}

         Write-Verbose ($myRemoteSessions | Out-String)
     } #begin

     Process {
        foreach ($item in $path) {

          #get the filesystem path for the item. Necessary if piping in a DIR command
          $itemPath = $item | Convert-Path

          #get the file contents in bytes
          $content = [System.IO.File]::ReadAllBytes($itempath)

          #get the name of the file from the incoming file
          $filename = Split-Path -Path $itemPath -Leaf

          #construct the destination file name for the remote computer
          $destinationPath = Join-path -Path $Destination  -ChildPath $filename
          Write-Verbose "Copying $itempath to $DestinationPath"

          #run the command remotely
          #define a scriptblock to run remotely
          $sb = {
          [cmdletbinding(SupportsShouldProcess=$True)]
          Param([bool]$Passthru,[bool]$WhatifPreference)

          #test if path exists
          if (-Not (Test-Path -Path $using:Destination)) {
            #this should never be reached since we are testing in the begin block
            #but just in case...
            Write-Warning "[$env:computername] Can't find path $using:Destination"
            #bail out
            Return
          }

          #values for WhatIf
          $target = "[$env:computername] $using:DestinationPath"
          $action = 'Copy Remote File'

          if ($PSCmdlet.ShouldProcess($target,$action)) {
              #create the new file
              [System.IO.File]::WriteAllBytes($using:DestinationPath,$using:content)

              If ($passthru) {
                #display the result if -Passthru
               Get-Item $using:DestinationPath
              }
          } #if should process

          } #end scriptblock

          Try {
            Invoke-Command -scriptblock $sb -ArgumentList @($Passthru,$WhatIfPreference) -Session $myRemoteSessions -ErrorAction Stop
          }
          Catch {
            Write-Warning "Command failed. $($_.Exception.Message)"
          }
        }
     } #process

     End {
        #remove PSSession
        Write-Verbose "Removing PSSessions"
        if ($myRemoteSessions) {
          #always remove sessions regardless of Whatif
          $myRemoteSessions | Remove-PSSession -WhatIf:$False
        }
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
     } #end

} #end function
