$rootOu = Read-Host "Welche OU soll vollständig gelöscht werden (z. B. 'Testlab')"

$ouPath = "OU=$rootOu,DC=deinefirma,DC=local"

# Benutzer löschen
Get-ADUser -Filter * -SearchBase "OU=_User,$ouPath" | Remove-ADUser -Confirm:$false

# Gruppen löschen
Get-ADGroup -Filter * -SearchBase "OU=_Gruppen,$ouPath" | Remove-ADGroup -Confirm:$false

# OUs rekursiv löschen (von unten nach oben)
$unterOUs = @("_Verteilung", "_Sicherheit", "_Projekte", "_Standorte", "_Archiv", "_Gruppen", "_Terminalserver", "_Server", "_Clients", "_User")
foreach ($ou in $unterOUs) {
    $fullPath = "OU=$ou,$ouPath"
    if (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$fullPath'" -ErrorAction SilentlyContinue) {
        Remove-ADOrganizationalUnit -Identity $fullPath -Recursive -Confirm:$false
    }
}

# Root-OU löschen
Remove-ADOrganizationalUnit -Identity $ouPath -Recursive -Confirm:$false

Write-Host "Alle Objekte unter '$rootOu' wurden entfernt."
