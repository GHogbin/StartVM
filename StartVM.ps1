# Login into Azure
$Credential = Get-Credential
Connect-AzAccount -Credential $Credential 
# List Subscriptions
$Subscription = Get-AzSubscription | select Name, ID | Out-GridView -PassThru
    Set-AzContext -SubscriptionID $($Subscription.Id)
# List Resource Groups
$resourcegroupname = Get-AzResourceGroup | Out-GridView -PassThru
# List VM's in Resource Group
$vmname = Get-AzVM -ResourceGroupName $($resourcegroupname.ResourceGroupName) | Out-GridView -PassThru
# Start Selected VM
Start-AzVM -Name $($vmname.Name) -ResourceGroupName $($resourcegroupname.ResourceGroupName)
# Obtain Private IP  for VM
$vmNIC = (Get-AzNetworkInterface -ResourceGroupName RG-Hopkind-ADM).Name
$interface = Get-AzNetworkInterface -Name $vmNIC -ResourceGroupName RG-Hopkind-ADM
$privateip = (Get-AzNetworkInterfaceIpConfig -NetworkInterface $interface).PrivateIpAddress
# RDP into VM
mstsc /v:$privateip