$name=Get-content "g:\servers.txt"
foreach ($name in $name)
{
Get-WmiObject -Class win32_process -ComputerName $name | 
    Where-Object{ $_.Name -eq "explorer.exe" } | 
    ForEach-Object{ $name + "=" + ($_.GetOwner()).Domain + "\" + ($_.GetOwner()).User; }
}

