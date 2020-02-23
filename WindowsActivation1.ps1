$VM=get-content "G:\servers.txt"
Foreach ($VM in $VM)
{
$Status = (Get-CimInstance -computername $VM -ClassName SoftwareLicensingProduct -Filter "Name like 'Windows%'" | where PartialProductKey).licensestatus 
If ($Status -ne 1) {write-Host "$VM - Windows is not activated"} else {write-Host "$VM - Windows is activated"}
}
