$Vms = Get-Content -Path G:\servers.txt
$output += ForEach ($vm in $vms) {Get-WmiObject -Class Win32_Product -Computer $vm | Select-Object PScomputername,Name, Version | Where-Object -FilterScript {$_.Name -like "Dell SecureWorks*"}}
$output | out-file G:\versions.txt