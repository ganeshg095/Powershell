$server   = get-content "G:\servers.txt"
foreach ($server in $server)
{
$username = "kzlnet/gselvarajan"
$session = ((quser /server:$server | ? { $_ -match $username }) -split ' +')
logoff $session /server:$server
}