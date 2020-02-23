get-adcomputer -Filter * | %{ Invoke-Command -Computer $_.Name -ScriptBlock {Get-CimInstance -ClassName SoftwareLicensingProduct -ComputerName $ComputerName |`
    Where{$_.PartialProductKey -and $_.Name -like "*Windows*"} | Select `
    @{Expression={$_.PSComputerName};Name="ComputerName"},`
    @{Expression={$_.Name};Name="WindowsName"} ,ApplicationID,`
    @{Expression={$LicenseStatus[$($_.LicenseStatus)]};Name="LicenseStatus"}} }