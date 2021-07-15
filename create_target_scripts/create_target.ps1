$vm_name = "#{Project.Azure.VM.Name}"
$resource_group = "#{Project.Azure.RG.Name}"

az vm run-command invoke --command-id RunPowerShellScript --name $vm_name -g $resource_group --scripts "@install_tentacle.ps1"
./auto_register_target.ps1