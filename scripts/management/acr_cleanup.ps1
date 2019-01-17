# This script check and removes the old docker images from the azure container registry

# This script will cleaup images in Azure ACR
#
# Required arguments:
# Service Principal Name
# Service Principal Pass
# Service Principal Tenant
# Azure Registry Name
#
# Example: .\ACR-Cleanup.ps1 -ServicePrincipalId $spid -ServicePrincipalPass $spp -ServicePrincipalTenant $spt -AzureRegistryName $acrregistry

[CmdletBinding()]
Param(
    # Define Service Prinicipal Name for Azure authentication
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $ServicePrincipalId,

    # Define Service Prinicial key for Azure authentication
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $ServicePrincipalPass,

    # Define Tenant ID for Azure authentication
    [Parameter (Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $ServicePrincipalTenant,

    # Define Azure Subscription Name
    [Parameter (Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String] $subscriptionName,

    # Define ACR Name
    [Parameter (Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $azureRegistryName,

    # Gets no of days from user; images older than this will be removed
    [Parameter (Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String] $NoOfDays = "30"
)

Write-Host "Establishing authentication with Azure..."
az login --service-principal -u $ServicePrincipalId -p $ServicePrincipalPass --tenant $ServicePrincipalTenant

if ($subscriptionName){
    Write-Host "Setting subscription to: $SubscriptionName"
    az account set --subscription $SubscriptionName
}

Write-Host "Checking registry: $azureRegistryName"
$repositoryList = az acr repository list --name $azureRegistryName --output json | ConvertFrom-Json
$repositoryList = $repositoryList | Sort-Object

Write-Host "Importing CSV Content"
$deployed = Import-Csv C:\Temp\acr-cleanup-deployed.csv

foreach($repository in $repositoryList) {
    Write-Host "Getting tags for repository: $repository"
    $repositoryTags = az acr repository show-tags --name $azureRegistryName --repository $repository --output json --detail --orderby time_desc | ConvertFrom-Json
    $repositoryTags = $repositoryTags | Select-Object createdTime, digest, name

    $count = 0

    foreach($tag in $repositoryTags) {
        $createDate = ($tag.createdTime).Substring(0,10)
        $parseDate = [datetime]::ParseExact($createDate,'yyyy-MM-dd', $null)
        $imageName = $tag.name

        $count++

        if ($count -le 20) {
            Write-Host "$count/20 - Skipping $imageName"
        } elseif ($imageName -in $deployed.tag) {
            Write-Host "Skipping as deployed: $imageName"
            Pause
        } elseif ($parseDate -lt $((Get-Date).AddDays(-$NoOfDays))) {
            Write-Host "Older than 30 days. Deleting image: $imageName"
            #az acr repository delete --name $azureRegistryName --image $imageName --yes
        } else {
            Write-Host "Image likely not over 30 days - $imageName $parseDate $createDate"
        }
    }
}

Write-Host "Logging out of Azure"
az logout

Write-Host "Script execution finished"
