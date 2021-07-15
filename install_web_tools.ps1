Write-Host "Installing and configuring IIS...."
Dism /Online /Enable-Feature /FeatureName:IIS-ASPNET45 /All
Dism /Online /Enable-Feature /FeatureName:IIS-CertProvider /All
Dism /Online /Enable-Feature /FeatureName:IIS-HttpRedirect /All
Dism /Online /Enable-Feature /FeatureName:IIS-BasicAuthentication /All
Dism /Online /Enable-Feature /FeatureName:IIS-WebSockets /All
Dism /Online /Enable-Feature /FeatureName:IIS-ApplicationInit /All
Dism /Online /Enable-Feature /FeatureName:IIS-CustomLogging /All
Dism /Online /Enable-Feature /FeatureName:IIS-ManagementService /All
Dism /Online /Enable-Feature /FeatureName:IIS-WindowsAuthentication /All

Write-Host "Installing dotnet core IIS hosting module...."
choco install dotnet-aspnetcoremodule-v2 -y

Write-Host "Installing dotnet 5 sdk & runtime...."
choco install dotnet-5.0-sdk -y
choco install dotnet-5.0-runtime -y