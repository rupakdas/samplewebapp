# connect to azure account
Connect-AzAccount

# Create resource grp
$Location='East US'
$ResourceGroupName='web-grp'

New-AzResourceGroup -Location $Location -Name $ResourceGroupName

# Create AppService Plan
$AppServicePlan='webapps'
New-AzAppServicePlan -Location $Location -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -Tier Free

# Create WebApp
$WebApp='webapprd01'
New-AzWebApp -Location $Location -ResourceGroupName $ResourceGroupName -AppServicePlan $AppServicePlan -Name $WebApp

# Define Project Properties
$ProjectProps=@{
    repoUrl = "https://github.com/rupakdas/samplewebapp.git";
    branch = "main";
    isManualIntegration = "true";
}

# Deploy web app 
Set-AzResource -ResourceGroupName $ResourceGroupName -PropertyObject $ProjectProps `
-ResourceType Microsoft.Web/sites/sourcecontrols `
-ResourceName $WebApp/web -ApiVersion 2015-08-01 -Force
