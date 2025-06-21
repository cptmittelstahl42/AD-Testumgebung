# Homefolder-Basispfad definieren
$homeBase = "\\fileserver\home$"
$ou = "OU=_User,OU=DeineOU,DC=deinefirma,DC=local"

# Benutzer abrufen
$benutzer = Get-ADUser -Filter * -SearchBase $ou -Properties SamAccountName

foreach ($user in $benutzer) {
    $homePath = Join-Path $homeBase $user.SamAccountName
    if (-not (Test-Path $homePath)) {
        New-Item -Path $homePath -ItemType Directory | Out-Null
        $acl = Get-Acl $homePath
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$($user.SamAccountName)", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($rule)
        Set-Acl -Path $homePath -AclObject $acl
        Write-Host "Homeverzeichnis erstellt für $($user.SamAccountName)"
    }
}
