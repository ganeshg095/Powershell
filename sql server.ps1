$vm = get-content G:\servers.txt
foreach ($vm in $vm)
{
$sql = get-service -computername $vm |where{$_.name -like "*SQL*"}

if ($sql.Status -eq "Running") {
    Write-Host "SQL is running on $vm"
} 
else {
    Write-Host "SQL is not running on $vm"
}
}