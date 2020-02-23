Function Percentcal {
    param(
    [parameter(Mandatory = $true)]
    [int]$InputNum1,
    [parameter(Mandatory = $true)]
    [int]$InputNum2)
    $InputNum1 / $InputNum2*100
}
$datastores = Get-Datastore | Sort Name
ForEach ($ds in $datastores)
{
    if (($ds.Name -match “Shared”) -or ($ds.Name -match “”))
    {
        $PercentFree = Percentcal $ds.FreeSpaceMB $ds.CapacityMB
        $PercentFree = “{0:N2}” -f $PercentFree
        $ds | Add-Member -type NoteProperty -name PercentFree -value $PercentFree
    }
}
$datastores | Select Name,@{N=”UsedSpaceGB”;E={[Math]::Round(($_.ExtensionData.Summary.Capacity – $_.ExtensionData.Summary.FreeSpace)/1GB,0)}},@{N=”TotalSpaceGB”;E={[Math]::Round(($_.ExtensionData.Summary.Capacity)/1GB,0)}} ,PercentFree | Export-Csv G:\datastorereport.csv -NoTypeInformation