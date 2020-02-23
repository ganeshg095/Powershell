$vms=Get-Content -Path "g:\servers.txt"
ForEach ($vm in $vms) {
    Invoke-Command -ComputerName $vm -ScriptBlock { 
Write-host $vm
Get-CimInstance -ClassName SoftwareLicensingProduct |
 Where-Object PartialProductKey | 
   Select-Object Name, ApplicationId, LicenseStatus 
}}