$vm = get-content G:\servers.txt
foreach ($vm in $vm)
{
$iis = Get-WmiObject Win32_Service -ComputerName $vm -Filter "name='IISADMIN'"

if ($iis.State -eq "Running") {
    Write-Host "IIS is running on $vm"
} 
else {
    Write-Host "IIS is not running on $vm"
}
}
