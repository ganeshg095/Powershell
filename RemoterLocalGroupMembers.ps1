#Need to change Input file location.
$ServerPath = Get-Content  G:\Servers.txt
#$ServerPath = Hostname
Foreach ($Server in $ServerPath)
{
        #to find local groups
        $Computer = $Server
        $Computer = [ADSI]"WinNT://$Computer"
        $Localgroups=($Computer.psbase.Children | Where {$_.psbase.schemaClassName -eq "group"}).name                       
        #$Localgroups= (Get-WMIObject win32_group -filter "LocalAccount='True'" -ComputerName $Server).Name
        #$Localgroups.trimend()
        #for finding each Group members using foreach
        foreach ($groupname in $Localgroups ) {
        $group =[ADSI]"WinNT://$server/$groupname" 
        $members = @($group.psbase.Invoke("Members"))
        Foreach ($m in $members)
            {
                New-Object psobject -Property @{
                        GroupName = $Groupname
                        ComputerName = $Server
                        Members = $m.GetType().InvokeMember("Name", 'GetProperty', $null, $m, $null)
             } |Export-csv -NoTypeInformation -Append -Path G:\All_LocalGroup_members.csv
            }
      }
 } 
