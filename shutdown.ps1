foreach($vmlist in (Get-Content -Path G:\servers.txt)){
$vm = Get-VM -Name $vmlist
Stop-VM -VM $vm -Confirm:$false
}