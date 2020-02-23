$computers = Get-Content -path g:\servers.txt
foreach ($computer in $computers)
{
Get-hotfix -ComputerName $computer | sort installedon -desc | select pscomputername, Description, Hotfixid, installedon -first 5
}