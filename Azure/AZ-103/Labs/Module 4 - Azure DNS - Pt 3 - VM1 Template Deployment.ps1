# the lab says to upload .json file and run New-AzResourceGroupDeployment -ResourceGroupName $rg2.ResourceGroupName -TemplateFile "./az-100-04b_01_azuredeploy.json" -TemplateParameterFile "./az-100-04_azuredeploy.parameters.json" -AsJob

# I want to reference raw github file

$raw_deploy_file = "https://raw.githubusercontent.com/MicrosoftLearning/AZ-103-MicrosoftAzureAdministrator/master/Allfiles/Labfiles/Module_04/Configure_Azure_DNS/az-100-04b_01_azuredeploy.json"
$raw_params_file = "https://raw.githubusercontent.com/MicrosoftLearning/AZ-103-MicrosoftAzureAdministrator/master/Allfiles/Labfiles/Module_04/Configure_Azure_DNS/az-100-04_azuredeploy.parameters.json"

New-AzResourceGroupDeployment -ResourceGroupName $rg2.ResourceGroupName -TemplateFile $ raw_deploy_file `
  -TemplateParameterFile $raw_params_file -AsJob

# Azure CLI: az group deployment create -g arm-template --template-uri $raw_deploy_file --parameters $raw_params_file

