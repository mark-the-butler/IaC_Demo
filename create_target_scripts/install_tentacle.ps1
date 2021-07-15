Write-Host "Creating temp directory...."
New-Item "C:\Windows\system32\config\systemprofile\AppData\Local\Temp" -ItemType Directory -Force

Write-Host "Installing chocolatey...."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Host "Installing Octopus tentacle...."
choco install octopusdeploy.tentacle -y

$tentacle_name = "#{Project.Azure.Target.Name}"
$octopus_thumbprint = "#{Project.Octopus.Thumbprint}"

Write-Host "Changing directories to tentacle installation folder...."
Set-Location "C:\Program Files\Octopus Deploy\Tentacle"

Write-Host "Creating tentacle instance...."
.\Tentacle.exe create-instance --instance $tentacle_name --config "C:\Octopus\Tentacle.config" --console
.\Tentacle.exe new-certificate --instance $tentacle_name --if-blank --console
.\Tentacle.exe configure --instance $tentacle_name --reset-trust --console
.\Tentacle.exe configure --instance $tentacle_name --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
.\Tentacle.exe configure --instance $tentacle_name --trust $octopus_thumbprint --console
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
.\Tentacle.exe service --instance $tentacle_name --install --start --console