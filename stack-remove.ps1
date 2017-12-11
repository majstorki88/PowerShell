$stack = Read-Host 'Enter stack name for removing';
docker stack rm $stack


$title = "Remove stack components"
$message = "Do you want to delete all stack components?
WARNING! This will remove:
        - all exited containers
        - all dangling images
        - all unused volumes"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Deletes all the files in the folder."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Retains all the files in the folder."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 {$volume5= docker volume ls -f dangling=true
           docker volume rm $volume5 --quiet --no-verbose >$null 2>&1
           $images5 = docker images -q --filter dangling=true 
           docker rmi $images5 --quiet --no-verbose >$null 2>&1
           $containers5 = docker ps -aq -f status=exited
           docker rm $containers5 --quiet --no-verbose >$null 2>&1
           "All components are removed"}
        1 {"Only stack is removed"}
    }
