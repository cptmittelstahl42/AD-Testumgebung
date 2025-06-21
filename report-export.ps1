# OU der Testuser definieren
$ou = "OU=_User,OU=DeineOU,DC=deinefirma,DC=local"

# Benutzerinformationen sammeln
$users = Get-ADUser -Filter * -SearchBase $ou -Properties GivenName,Surname,SamAccountName,Department,EmailAddress,OfficePhone

# Export
$users | Select-Object GivenName,Surname,SamAccountName,Department,EmailAddress,OfficePhone |
Export-Csv -Path ".\AD-TestUser-Report.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Benutzerbericht erfolgreich als AD-TestUser-Report.csv exportiert."
