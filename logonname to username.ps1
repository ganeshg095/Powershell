<#
5 lines highlighted in yellow needs to be changed according to  project.

1.	Recipients  email has to be DL @hexaware.com
2.	CSV File path ( where you want to save and update the file) eg here c:\fso\co.csv
3.	Server List in Servers_all.txt
4.	Connection String for SQL Email Service 
5.	Profile Name 
#>

$recipients = "@hexaware.com" # For Testing
$csvfile="g:\co.csv"
$ServerListFile = "g:\Servers.txt" 


$titleDate = get-date -uformat "%m-%d-%Y - %A"
$trackerdatetime = get-date -Format G
$trackerdate = get-date
$now=Get-Date -format "dd-MMM-yyyy"


#$mailsubject = 'Memory and CPU Utilization'
#$subject = 'Servers Memory and CPU Utilization'+ $titleDate


#Set colors for table cell backgrounds
$redColor = "#FF0000"
$orangeColor ="#FBB917"
$whiteColor = "#FFFFFF"
$greenColor ="#00FF00"

$percentCPU =75;
$percentMEM =80;


$ServerList = Get-Content $ServerListFile -ErrorAction SilentlyContinue 
# $computers = $env:computername
$Result = @() 
$Final=""



$Title = "<HTML><TITLE> $subject </TITLE>
                                                                           <BODY background-color:peachpuff>
                                                                           <font color =""#003399"" face=""Microsoft Tai le"">
                                                                           </font>"


              $Summaryreport = "<Table border=1 cellpadding=0 width='70%'><font face='tahoma' size='2'>
                                                                              <TR bgcolor='#CCCCCC'>
                                                                              <TD class ='server' width='15%' align='center'>Server Date </TD>
                                                                              <TD class ='server' width='15%' align='center'>Server Name</TD>
                                                                              <TD class ='cin' width='10%' align='center'>CPU Information</TD>
                                                                              <TD class ='min' width='10%' align='center'>Memory Information</TD>
                                                                              <TD class ='cut' width='10%' align='center'>Avg CPU Utilization</TD>
                                                                              <TD class ='mut' width='10%' align='center'>Avg Memory Utilization</TD>
                                                                              </TR>"
                           
Add-Content -Path g:\co.csv  -Value '"Date","ServerName","CPU","Memory(GB)","Avg CPU %","Avg Memory %"'                                               

ForEach($computername in $ServerList) 
              {
                                         
                                                      
                                         #CPU Information
                                         $SystemProcessor = Get-WmiObject -Class Win32_Processor -ComputerName $computername

                                         $systempro = $SystemProcessor.Name
                                         # ("Hello world").Substring(2,5)
                                         $partprod = $systempro.Substring($systempro.length-7)
                                         
                                         #Memory Information
                                         $PhysicalRAM = (Get-WMIObject -class Win32_PhysicalMemory -ComputerName $computername |Measure-Object -Property capacity -Sum | % {[Math]::Round(($_.sum / 1GB),2)})
                                            
                                         $AVGProc = Get-WmiObject -computername $computername win32_processor | 
                                         Measure-Object -property LoadPercentage -Average | Select Average
                                         
                                         $OS2 = gwmi -Class win32_operatingsystem -computername $computername |
                                         Select-Object @{Name = "MemoryUsage"; Expression = {[math]::Round((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}
                                         
              if(!$SystemProcessor)
                     {
                                         # $disks = Get-SshSession - ComputerName $computer
                                         # Write-Host $computer "not exist"
                                           $currentRecord = "
                                                          <TR align='center'>
                                                                <TD>$now</TD>
                                                                <TD>$computername</TD>
                                                                <TD>$computername Not Available</TD>
                                                                <TD></TD>
                                                                <TD></TD>
                                                                <TD></TD>
                                                                 </TR>"
                                  
                     }
                                         
                     else
                     {
                                                
                                                $ServerName = $computername
                                                $CPUINFO =$partprod
                                                $MEMINFO =$PhysicalRAM
                                                $CPULoad = $AVGProc.Average
                                                $MemLoad = $OS2.MemoryUsage
                                                
                                                       if($CPULoad -ge $percentCPU)
                                                {
                                                $colorcpu = $redColor 
                                                # $SummaryRecord = "<TR align='center'>
                                                                     # <TD>$TYPE</TD>
                                                                # <TD>$now</TD>
                                                                # <TD>$Servername</TD>
                                                                # <TD>$CPUINFO</TD>
                                                                # <TD>$MEMINFO GB</TD>
                                                                # <TD bgcolor=`'$colorcpu`'>$CPULoad%</TD>
                                                                # <TD bgcolor=`'$colormem`'>$MemLoad%</TD>
                                                                 # </TR>"
                                                       # $Summaryreport += $SummaryRecord         
                                                 
                                                }
                                                # Red if if space is Critical
                                                elseif($CPULoad -lt $percentCPU)      
                                                {
                                                $colorcpu = $greenColor    
                                                }                                               
                                                
                                                if($MemLoad -ge $percentMEM)
                                                {
                                                $colormem = $redColor 
                                                # $SummaryRecord = "<TR align='center'>
                                                                     # <TD>$TYPE</TD>
                                                                # <TD>$now</TD>
                                                                # <TD>$Servername</TD>
                                                                # <TD>$CPUINFO</TD>
                                                                # <TD>$MEMINFO GB</TD>
                                                                # <TD bgcolor=`'$colorcpu`'>$CPULoad%</TD>
                                                                # <TD bgcolor=`'$colormem`'>$MemLoad%</TD>
                                                                 # </TR>"
                                                                 
                                                  # $Summaryreport += $SummaryRecord
                                                }
                                                # Red if if space is Critical
                                                elseif($MemLoad -lt $percentMEM)      
                                                {
                                                $colormem = $greenColor    
                                                }
                                                
                                                
                                  $currentRecord = "<TR align='center'>
                                                                <TD>$now</TD>
                                                                <TD>$Servername</TD>
                                                                <TD>$CPUINFO</TD>
                                                                <TD>$MEMINFO GB</TD>
                                                                <TD bgcolor=`'$colorcpu`'>$CPULoad%</TD>
                                                                <TD bgcolor=`'$colormem`'>$MemLoad%</TD>
                                                                 </TR>"           
                                                              
                                         
                     }

                                         



$Record = @{
    "Date" = ""
    "ServerName" = ""
    "CPU" = ""
    "Memory(GB)" = ""
    "Avg CPU %" = ""
    "Avg Memory %" = ""
    
    }

$Record."Date"=$trackerdatetime
$Record."ServerName"=$Servername
$Record."CPU"=$CPUINFO
$Record."Memory(GB)"=$MEMINFO
$Record."Avg CPU %"=$CPULoad
$Record."Avg Memory %"=$MemLoad


    $objRecord = New-Object PSObject -property $Record
    #$Table += $objrecord

    

    $newRow = New-Object PsObject -Property $Record
    Export-Csv $csvfile -inputobject $newrow -append -Force
    $Final+= $currentRecord
    $currentRecord=""

    }


                     
              Write-Host "Writing Files"

                    
                 $FinalReport = $Title + $Summaryreport + $Final +"</table><br>"
                
                                                                        
 
  
 
  $FinalReport | out-file g:\UtilizationReport.html
  
  <#
  #Write-Host "Sending Email notification to $recipients"
              
                     $con = New-Object System.Data.SqlClient.SqlConnection
                     $con.ConnectionString = "server=NUPOMSPRDDB1; database=msdb;User ID=DCTSqlUser;Password=Dct#@!321;"
                     $con.open()
                     Write-Host 'Connected'
                     $cmd = New-Object System.Data.SqlClient.SqlCommand
                     $cmd.Connection = $con
                     $cmd.CommandType = [System.Data.CommandType]"StoredProcedure"
                     $cmd.CommandText = "sp_send_dbmail"
                     $cmd.Parameters.AddWithValue("@profile_name", 'POMS')
                     $cmd.Parameters.AddWithValue("@recipients", $recipients)
                     $cmd.Parameters.AddWithValue("@subject",$mailsubject )
                     $cmd.Parameters.AddWithValue("@body", $FinalReport)
                     $cmd.Parameters.AddWithValue("@body_format", 'HTML')
                     $cmd.ExecuteNonQuery()

                     $con.Close()

#>

