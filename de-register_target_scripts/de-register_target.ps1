$OctopusURL = "#{Project.Octopus.Url}"
$APIKey = "#{Project.Octopus.ApiKey}"
$SpaceName = "default"
$roleName = "#{Project.Octopus.Target.Azure.RoleName}"

$header = @{ "X-Octopus-ApiKey" = $APIKey }

# Get space
$space = (Invoke-RestMethod -Method Get -Uri "$octopusURL/api/spaces/all" -Headers $header) | Where-Object {$_.Name -eq $spaceName}

Write-Host "Getting a list of all machines"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$targetList = (Invoke-RestMethod "$OctopusUrl/api/$($space.Id)/machines?skip=0&take=1000" -Headers $header)

foreach($target in $targetList.Items)
{
    if ($target.Roles -contains $roleName)
    {
        $targetId = $target.Id
        #Write-Highlight "Deleting the target $targetId because the name matches"
        $deleteResponse = (Invoke-RestMethod "$OctopusUrl/api/$($space.Id)/machines/$targetId" -Headers $header -Method Delete)

        Write-Host "Delete Response $deleteResponse"
    }
}