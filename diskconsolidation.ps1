connect-viserver kimvc55 -user kzlsrvc-veeam
get-view -ViewType VirtualMachine -Property Name, "Runtime", "LayoutEx.File"  | %{
	$vmName = $_.name
	if($_.runtime.consolidationNeeded) {
		$consolidation = $_.runtime.consolidationNeeded
		$consolidationcount++
		$deltadisks = ($_.LayoutEx.File | where {$_.name -like "*-000*.vmdk"}).count
		$consolidationlist += "" | select-object  @{n="VmName";e={$vmName}},@{n="Consolidation";e={$consolidation}},@{n="Delta Disks";e={$deltadisks}}
	}
}
if($consolidationcount -gt 0)
{
	write-host "VM's needing conslodation: $consolidationcount"
	#Print out our table
	$consolidationlist | format-table -autosize
}
else{
	write-host "No virtual machines require consolidation"
}