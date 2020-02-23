$Servers = Get-Content -Path "G:\servers.txt"
$DestinationServ = "52.72.172.158"
$Array = @()
$Port = "1500"
 
Foreach($Server in $Servers)
{
    $Obejct = $null
    $FQDN = $null
    $Server = $Server.Trim()
 
    Write-Host Processing $Server -ForegroundColor Green
     
    #Check FQDN for remote computer 
    $FQDN = ([System.Net.Dns]::GetHostByName(("$Server")))
 
    If(!$FQDN)
    {
        Write-Host "$Server does not exist"
    }
    Else
    {
        # Create a custom object 
        $Object = New-Object PSCustomObject
        $Object | Add-Member -MemberType NoteProperty -Name "Server name" -Value $server
        $Object | Add-Member -MemberType NoteProperty -Name "Port" -Value $Port
 
        Foreach($DServer in $DestinationServ)
        {
            $Test = $null
            Try
            {
                $Test = Invoke-Command  -ComputerName $Server -ErrorAction Stop -ScriptBlock{param($Port,$DServer) Test-netconnection -Port $Port -cn $DServer -InformationLevel Quiet } -ArgumentList $Port,$DServer
                If($Test)
                {
                    $Object | Add-Member -MemberType NoteProperty -Name "$DServer" -Value $Test
                }
            }
            Catch
            {
                Write-Warning $_.Exception.Message
                $Object | Add-Member -MemberType NoteProperty -Name "$DServer" -Value "null"
            }
        }
        $Array += $Object  
 
    }
}
Write-Host "Results:" -Foreground Yellow
$Array | Format-Table -Wrap -AutoSize
$Array | Export-Csv -Path G:\telnet_results.csv -NoTypeInformation