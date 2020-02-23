$ESXiHostSrc = "kimvm5-g613.kzlnet.com"  
$ESXiHostDst = "kimvm5-g612.kzlnet.com"  
$vmList = get-content G:\servers.txt  
Get-VM $vmList | move-vm -destination (get-vmhost $ESXiHostDst) 