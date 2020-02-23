$vm = get-content G:\servers.txt
foreach ($vm in $vm)
{
$iis = Get-WmiObject Win32_Service -ComputerName $vm -Filter "name='CcmExec'"

if ($iis.State -eq "Running") {
    Write-Host "SCCM is running on $vm"
} 
else {
    Write-Host "SCCM is not running on $vm"
}
}
