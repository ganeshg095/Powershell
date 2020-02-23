# Get users
$users = Get-ChildItem -Path "G:\Users.txt"

# Loop through users and delete the file
$users | ForEach-Object {
    Remove-Item -Path "C:\Users\$($_.Name)" -Force
}