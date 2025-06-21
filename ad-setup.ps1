# +--------------------------------------------+
# | Script zum Erstellen von OUs und Testuser  |
# | Inkl. Gruppen, Gruppenzuordnung, Adressen  |
# | Autor: Boettcher, Tim                      |
# | Stand: 21.06.2025                          |
# +--------------------------------------------+

function RandomUser([int]$Zahl) {
   $vornamen = @(
"Alexander", "Ben", "Clara", "David", "Emma", "Felix", "Greta", "Hannah", "Isabel", "Jonas",
"Karl", "Lea", "Max", "Nina", "Oliver", "Paula", "Quentin", "Rosa", "Samuel", "Tina",
"Uwe", "Valentina", "Willi", "Xenia", "Yannic", "Zoe", "Anja", "Bastian", "Carla", "Dario",
"Elisa", "Finn", "Gina", "Henrik", "Ines", "Julius", "Katja", "Lukas", "Mia", "Nico",
"Olga", "Peter", "Quirin", "Romy", "Simon", "Tabea", "Ulrike", "Viktor", "Wanda", "Xaver",
"Yara", "Zoran", "Andrea", "Bruno", "Celine", "Denis", "Eva", "Fabian", "Gesa", "Heike",
"Ibrahim", "Jan", "Kira", "Leon", "Marek", "Nadine", "Oskar", "Philipp", "Queenie", "Rafael",
"Sophie", "Tim", "Ulla", "Vanessa", "Walter", "Xaveria", "Yvonne", "Zacharias", "Amira", "Björn",
"Carsten", "Dilara", "Emil", "Franz", "Gustav", "Helena", "Ilja", "Jana", "Kai", "Lara",
"Marcel", "Noah", "Ortwin", "Patricia", "René", "Stefan", "Theresa", "Udo", "Vera", "Winfried"
)
$nachnamen = @(
"Müller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Hoffmann", "Schäfer",
"Koch", "Bauer", "Richter", "Klein", "Wolf", "Schröder", "Neumann", "Schwarz", "Zimmermann", "Braun",
"Krüger", "Hofmann", "Hartmann", "Lange", "Schmitt", "Werner", "Schmitz", "Krause", "Meier", "Lehmann",
"Schmid", "Schulz", "Maier", "Köhler", "Herrmann", "König", "Walter", "Mayer", "Huber", "Kaiser",
"Fuchs", "Peters", "Lang", "Scholz", "Möller", "Weiß", "Jung", "Hahn", "Keller", "Vogel",
"Roth", "Beck", "Lorenz", "Franke", "Berger", "Winkler", "Baumann", "Winter", "Graf", "Schuster",
"Simon", "Ludwig", "Böhm", "Bergmann", "Otto", "Günther", "Sommer", "Seidel", "Heinrich", "Brandt",
"Engel", "Haas", "Kramer", "Jansen", "Voigt", "Adam", "Scholten", "Arnold", "Reinhardt", "Horn",
"Krieger", "Voß", "Franz", "Paul", "Noack", "Albrecht", "Bach", "Dietrich", "Fröhlich", "Ritter",
"Grafen", "Ziegler", "Link", "Michel", "Brenner", "Wendt", "Schütz", "Funke", "Stahl", "Gebhardt"
)
    $Liste_Namen = @()
    $verwendeteNamen = @{}

    for ($i = 0; $i -lt $Zahl; ) {
        $vorname = Get-Random -InputObject $vornamen
        $nachname = Get-Random -InputObject $nachnamen
        $kombination = "$vorname $nachname"
        if (-not $verwendeteNamen.ContainsKey($kombination)) {
            $verwendeteNamen[$kombination] = $true
            $Liste_Namen += $kombination
            $i++
        }
    }
    return $Liste_Namen
}

# Modul laden
Import-Module ActiveDirectory

# OU-Name abfragen
$firstou = Read-Host "Wie soll die oberste OU heißen?"

# Globale Variablen
$domain = (Get-ADDomainController).Domain
$defaultpartition = (Get-ADDomainController).DefaultPartition
$parentpath = "OU=$firstou,$defaultpartition"
$serverpath = "OU=_Server,$parentpath"
$userpath = "OU=_User,$parentpath"
$grouppath = "OU=_Gruppen,$parentpath"
$password = "!Start123" | ConvertTo-SecureString -AsPlainText -Force

# OU-Struktur erstellen
New-ADOrganizationalUnit -Name $firstou -Path $defaultpartition
New-ADOrganizationalUnit -Name "_Clients" -Path $parentpath
New-ADOrganizationalUnit -Name "_Server" -Path $parentpath
New-ADOrganizationalUnit -Name "_Terminalserver" -Path $serverpath
New-ADOrganizationalUnit -Name "_User" -Path $parentpath
New-ADOrganizationalUnit -Name "_Gruppen" -Path $parentpath
New-ADOrganizationalUnit -Name "_Verteilung" -Path $grouppath
New-ADOrganizationalUnit -Name "_Sicherheit" -Path $grouppath
New-ADOrganizationalUnit -Name "_Projekte" -Path $grouppath
New-ADOrganizationalUnit -Name "_Archiv" -Path $grouppath

# Gruppenliste definieren
$gruppen = @("Vertrieb", "Marketing", "Einkauf", "Lager", "IT", "Vorstand", "Buchhaltung")

foreach ($grp in $gruppen) {
    if (-not (Get-ADGroup -Filter {Name -eq $grp} -SearchBase $grouppath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $grp -GroupScope Global -GroupCategory Security -Path $grouppath
    }
}

# Benutzeranzahl abfragen & Namen generieren
$number = Read-Host "Geben Sie die Anzahl der Testuser an"
$namenListe = RandomUser([int]$number)

# Zufallsobjekt für Telefonnummern
$random = New-Object System.Random
$vorstandCounter = 0
$vorstandLimit = 4

# Benutzer erzeugen
for ($i = 0; $i -lt $number; $i++) {
    $vollname = $namenListe[$i]
    $teile = $vollname -split " "
    $vorname = $teile[0]
    $nachname = $teile[1]
    $username = "$vorname.$nachname".ToLower()
    $upn = "$username@$domain"
    $telefon = "+49 40 1234-" + $random.Next(1000,9999)

    $gruppe = $gruppen[$i % $gruppen.Count]

    if ($gruppe -eq "Vorstand" -and $vorstandCounter -ge $vorstandLimit) {
        $gruppe = $gruppen[($i + 1) % $gruppen.Count]
    }

    $user = New-ADUser -Name $vollname `
                       -GivenName $vorname `
                       -Surname $nachname `
                       -SamAccountName $username `
                       -UserPrincipalName $upn `
                       -DisplayName $vollname `
                       -EmailAddress $upn `
                       -StreetAddress "Musterstraße 12" `
                       -City "Hamburg" `
                       -PostalCode "20095" `
                       -Company "Musterfirma AG" `
                       -Department $gruppe `
                       -Title "Testbenutzer" `
                       -OfficePhone $telefon `
                       -Description "Automatisch generierter Benutzer" `
                       -Initials ($vorname.Substring(0,1) + $nachname.Substring(0,1)) `
                       -AccountPassword $password `
                       -Enabled $true `
                       -Path $userpath `
                       -PassThru

    Add-ADGroupMember -Identity $gruppe -Members $user.SamAccountName

    if ($gruppe -eq "Vorstand") { $vorstandCounter++ }
}

Write-Host "`nFertig: $number Benutzer wurden erfolgreich angelegt und zugewiesen." -ForegroundColor Green
