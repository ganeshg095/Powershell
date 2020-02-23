$vm="g:\servers1.txt"
$Computers =  Get-content $Vm
$output=@()
ForEach($PSItem in $Computers) {
    $User = Get-CimInstance Win32_ComputerSystem -ComputerName $PSItem | Select-Object -ExpandProperty UserName
    $Obj = New-Object -TypeName PSObject -Property @{
        "Computer" = $PSItem
        "User" = $User
    }
$output+=$Obj    
}

$output