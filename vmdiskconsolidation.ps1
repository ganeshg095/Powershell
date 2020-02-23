$VMs = Get-VM | Where-Object {$_.ExtensionData.RunTime.ConsolidationNeeded}|out-file "G:\vmoutput.txt"


$vm=get-vm -name "vkimims12"
 Get-View -ViewType VirtualMachine -relatedobject $vm -Property Name, Runtime.ConsolidationNeeded -Filter @{'Runtime.ConsolidationNeeded' = 'False' } | write-host "VM ConsolidationNeeded"
