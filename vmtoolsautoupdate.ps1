$OutofDateVMs = Get-VM | % { get-view $_.id } |Where-Object {$_.Guest.ToolsVersionStatus -like "guestToolsNeedUpgrade"} |select name, @{Name=“ToolsVersion”; Expression={$_.config.tools.toolsversion}}, @{ Name=“ToolStatus”; Expression={$_.Guest.ToolsVersionStatus}}
ForEach ($VM in $OutOfDateVMs){Update-Tools -NoReboot -VM $VM.Name -Verbose}

