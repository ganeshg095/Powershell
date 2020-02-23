Import-Module -Name ActiveDirectory

$date = (get-Date).tostring()

$month = (Get-Date).AddDays(-30)

$ADcomputer = Get-adcomputer -Filter * -Properties whencreated | select name,whenCreated
$ADcomputer | export-csv -path G:\ADcomputer.csv -NoTypeInformation -Encoding UTF8



//$ADuserInmonth = Get-ADUser -Filter * -Properties whencreated | where { $_.whenCreated -ge $month } | select name,whenCreated