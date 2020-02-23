$ComputerName = get-content "G:\servers.txt"
$LicenseStatus = @("Unlicensed","Licensed","OOB Grace",
"OOT Grace","Non-Genuine Grace","Notification","Extended Grace")
$output= @()
Foreach($CN in $ComputerName)
{
   $output += Get-CimInstance -ClassName SoftwareLicensingProduct -ComputerName $ComputerName |`
    Where{$_.PartialProductKey -and $_.Name -like "*Windows*"} | Select `
    @{Expression={$_.PSComputerName};Name="ComputerName"},`	
    @{Expression={$_.Name};Name="WindowsName"} ,ApplicationID,`
    @{Expression={$LicenseStatus[$($_.LicenseStatus)]};Name="LicenseStatus"}
}
$output|export-csv -path c:\users\gselvarajan\documents\activation.csv -notypeinformation