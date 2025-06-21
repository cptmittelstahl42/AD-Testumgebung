# +--------------------------------------------+
# | Script zum Erstellen von OUs und Testuser  |
# | Inkl. Gruppen, Gruppenzuordnung, Adressen  |
# | Autor: Boettcher, Tim                      |
# | Stand: 21.06.2025                          |
# +--------------------------------------------+

function RandomUser([int]$Zahl) {
   $vornamen = @(
    "Franz", "Karl", "Hermann", "Walter", "Peter", "Rainer", "Manfred", "Klaus", "Horst", "Wolfgang",
    "Heinz", "Gunter", "Bernd", "Uwe", "Joachim", "Jorg", "Rolf", "Norbert", "Siegfried", "Reinhard",
    "Gisela", "Ingrid", "Monika", "Brigitte", "Renate", "Ursula", "Ilse", "Erika", "Helga", "Margot",
    "Edith", "Anneliese", "Gudrun", "Waltraud", "Heike", "Petra", "Birgit", "Rita", "Bettina", "Angelika",
    "Sascha", "Dirk", "Bjoern", "Stefan", "Holger", "Torsten", "Frank", "Marco", "Andreas", "Rico",
    "Nico", "Kevin", "Pascal", "Dominik", "Sven", "Enrico", "Kay", "Maik", "Timo", "Dennis",
    "Sabine", "Nicole", "Andrea", "Kerstin", "Claudia", "Sandra", "Melanie", "Stefanie", "Daniela", "Franziska",
    "Silke", "Judith", "Jasmin", "Yvonne", "Nadine", "Vanessa", "Tanja", "Diana", "Carina", "Miriam",
    "Thorsten", "Marcel", "Matthias", "Jens", "Patrick", "Oliver", "Carsten", "Mario", "Ronny", "Lars",
    "Annika", "Sina", "Carolin", "Kristin", "Nina", "Juliane", "Sarah", "Alina", "Lisa", "Josephine",
    "Franz", "Karl", "Hermann", "Walter", "Peter", "Rainer", "Manfred", "Klaus", "Horst", "Wolfgang",
    "Heinz", "Gunter", "Bernd", "Uwe", "Joachim", "Jorg", "Rolf", "Norbert", "Siegfried", "Reinhard",
    "Gisela", "Ingrid", "Monika", "Brigitte", "Renate", "Ursula", "Ilse", "Erika", "Helga", "Margot",
    "Edith", "Anneliese", "Gudrun", "Waltraud", "Heike", "Petra", "Birgit", "Rita", "Bettina", "Angelika",
    "Sascha", "Dirk", "Bjoern", "Stefan", "Holger", "Torsten", "Frank", "Marco", "Andreas", "Rico",
    "Nico", "Kevin", "Pascal", "Dominik", "Sven", "Enrico", "Kay", "Maik", "Timo", "Dennis",
    "Sabine", "Nicole", "Andrea", "Kerstin", "Claudia", "Sandra", "Melanie", "Stefanie", "Daniela", "Franziska",
    "Silke", "Judith", "Jasmin", "Yvonne", "Nadine", "Vanessa", "Tanja", "Diana", "Carina", "Miriam",
    "Thorsten", "Marcel", "Matthias", "Jens", "Patrick", "Oliver", "Carsten", "Mario", "Ronny", "Lars",
    "Annika", "Sina", "Carolin", "Kristin", "Nina", "Juliane", "Sarah", "Alina", "Lisa", "Josephine",
    "Georg", "Emil", "Alfred", "Otto", "Friedrich", "Ernst", "Wilhelm", "Ludwig", "Heinrich", "Theodor",
    "Gustav", "Hubert", "Alwin", "Willi", "Arno", "Erich", "Siegmar", "Konrad", "Detlef", "Lothar",
    "Gero", "Burkhard", "Volker", "Eberhard", "Jens-Peter", "Karl-Heinz", "Hans-Joachim", "Ruediger", "Alwin", "Kai-Uwe",
    "Agnes", "Irmgard", "Lieselotte", "Ottilie", "Margarete", "Rosel", "Wilhelmine", "Therese", "Berta", "Hildegard",
    "Anita", "Marianne", "Elfriede", "Josefine", "Annemarie", "Hedwig", "Gertrud", "Leni", "Rosa", "Else",
    "Jana", "Kim", "Celina", "Tamara", "Vivien", "Katharina", "Helene", "Veronika", "Pauline", "Antonia",
    "Marlene", "Greta", "Fiona", "Leonie", "Isabell", "Selina", "Lorena", "Chiara", "Elisa", "Merle",
    "Max", "Leonhard", "Till", "Samuel", "Florian", "Valentin", "Julius", "Frederik", "Vincent", "Korbinian",
    "Justus", "Benedikt", "Hanno", "Michel", "Markus", "Bastian", "Peer", "Levin", "Konstantin", "Caspar",
    "Elian", "Hannes", "Linus", "Malte", "Joris", "Nils", "Manuel", "Fabio", "Arne", "Henrik",
    "Hanno", "Torben", "Pascal", "Marc", "Jannik", "Tilo", "Julian", "Robin", "Morice", "Jerome",
    "Kenan", "Cedric", "Leopold", "Dominic", "Valentino", "Dennis-Leon", "Marvin", "Kai", "Leonid", "Timur",
    "Nikita", "Lenny", "Laurenz", "Christopher", "Tobias-Jan", "Janis", "Phil", "Tillmann", "Michelangelo", "Benno",
    "Magdalena", "Annette", "Beate", "Catharina", "Clarissa", "Dorothee", "Elsa", "Florentine", "Gundula", "Hanna-Maria",
    "Ivonne", "Janina", "Katrin", "Ludmilla", "Mareike", "Norina", "Olga", "Patricia", "Quirin", "Romina",
    "Saskia", "Tatjana", "Ute", "Viktoria", "Walburga", "Xenia", "Yasmin", "Zoe", "Aenne", "Beeke",
    "Carmen", "Dorit", "Elina", "Felicitas", "Gabriele", "Henriette", "Isolde", "Jacqueline", "Klara", "Lilli",
    "Marit", "Nele", "Odilia", "Pia", "Querina", "Romy", "Senta", "Theresia", "Ulla", "Vera",
    "Wilma", "Xaveria", "Ylvie", "Ziska", "Alex", "Chris", "Danny", "Elian", "Falk", "Gero",
    "Hauke", "Ingo", "Jaro", "Kian", "Loris", "Miran", "Neo", "Oskarino", "Peer", "Quentin",
    "Ragnar", "Sandro", "Tjark", "Ulf", "Veit", "Wolfram", "Xaver", "Yannik", "Zeno", "Adrian",
    "Bennet", "Can", "Dario", "Ege", "Ferdinand", "Gideon", "Hanno", "Ilja", "Jamil", "Keno",
    "Leif", "Maksim", "Nicolai", "Ole", "Pius", "Quintus", "Rayan", "Simeon", "Tamino", "Umut",
    "Vasco", "Wenzel", "Yves", "Zacharias", "Alea", "Bella", "Cleo", "Dilara", "Elif", "Finja",
    "Giulia", "Helin", "Ida", "Joleen", "Katja", "Lana", "Mina", "Nora", "Ortrud", "Penelope",
    "Queena", "Rieke", "Sarina", "Tabea", "Una", "Violetta", "Wanda", "Yelda", "Zara", "Anja",
    "Bianca", "Cora", "Dagmar", "Edeltraud", "Fee", "Grit", "Henny", "Irene", "Jacquelin", "Karla",
    "Leonie-Marie", "Martina", "Naemi", "Oda", "Paula", "Quirina", "Ronja", "Sonja", "Thekla", "Uschi",
    "Verena", "Waltraut", "Xandra", "Yara", "Zilli", "Artur", "Bruno", "Cornelius", "Dieter", "Egon",
    "Fritz", "Gerhard", "Hermann-Josef", "Ignaz", "Joerg", "Kilian", "Lorenz", "Matheo", "Norwin", "Otmar"
)
$nachnamen = @(
    "Mueller", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann", "Schaefer",
    "Koch", "Bauer", "Richter", "Klein", "Wolf", "Neumann", "Schwarz", "Zimmermann", "Braun", "Krueger",
    "Hofmann", "Hartmann", "Lange", "Schmitt", "Werner", "Schmitz", "Krause", "Meier", "Lehmann", "Schmid",
    "Schroeder", "Maier", "Koehler", "Herrmann", "Kaiser", "Huber", "Fuchs", "Peters", "Lang", "Scholz",
    "Moeller", "Weiss", "Jung", "Hahn", "Keller", "Vogel", "Friedrich", "Kunz", "Winter", "Busch",
    "Bergmann", "Thomas", "Franke", "Albrecht", "Simon", "Ludwig", "Baumann", "Boehm", "Otto", "Arnold",
    "Kuehn", "Voigt", "Sauer", "Heinrich", "Kuhn", "Engel", "Brandt", "Binder", "Kuehler", "Dietrich",
    "Lenz", "Schindler", "Graf", "Walter", "Seidel", "Hauser", "Hermann", "Roemer", "Albert", "Reuter",
    "Michel", "Lorenz", "Schuster", "Baer", "Brinkmann", "Schlegel", "Marx", "Arnold", "Burger", "Naumann",
    "Urban", "Freitag", "Kraemer", "Boettcher", "Heinze", "Kohl", "Schoen", "Muench", "Heinz", "Bachmann",
    "Schreiber", "Berger", "Voelker", "Pohl", "Noack", "Roth", "Adam", "Jansen", "Schumacher", "Arnold",
    "Baer", "Kuesel", "Held", "Doering", "Selig", "Preuss", "Reinhardt", "Witt", "Stahl", "Heller",
    "Appel", "Konrad", "Geyer", "Baumeister", "Eckert", "Klemm", "Merten", "Seifert", "Boeck", "Gerlach",
    "Fromm", "Timm", "Pfaff", "Behrens", "Schubert", "Rieger", "Schwan", "Wuest", "Sachs", "Tillmann",
    "Merkel", "Klaas", "Bernhard", "Scholl", "Lohmann", "Kastner", "Schorr", "Ehret", "Glass", "Prinz",
    "Fendt", "Strauss", "Lutz", "Andres", "Haag", "Greiner", "Buhl", "Drescher", "Ziegler", "Schreiner",
    "Wulf", "Benz", "Kilian", "Jakob", "Rueckert", "Zoller", "Ruf", "Knorr", "Mahlow", "Fechner",
    "Schoene", "Langner", "Pfister", "Sprecher", "Baum", "Hellwig", "Koerber", "Laube", "Bienert", "Mattern",
    "Wieczorek", "Meissner", "Peschke", "Unger", "Stegmann", "Schwenk", "Bley", "Kueppers", "Weigel", "Zepf",
    "Reimann", "Gerber", "Albrecht", "Heinemann", "Strobel", "Teichmann", "Rademacher", "Heitmann", "Rath", "Seeger",
    "Bormann", "Kretschmer", "Hinrichs", "Altmann", "Petzold", "Gerhardt", "Loeffler", "Reinhart", "Braeunlich", "Doerr",
    "Roesner", "Blechschmidt", "Tittel", "Wendler", "Haucke", "Hagemann", "Weidner", "Feldmann", "Schramm", "Tappe",
    "Decker", "Rohrbach", "Sandner", "Reichel", "Betz", "Haag", "Mangold", "Kleemann", "Roloff", "Kroeger",
    "Wirth", "Kube", "Brueckner", "Schnell", "Franz", "Tobias", "Weingarten", "Lechner", "Bendel", "Foerster",
    "Tesch", "Naef", "Vesper", "Blum", "Geissler", "Naegele", "Voelz", "Haenel", "Stephan", "Lamprecht",
    "Schilling", "Kunze", "Manske", "Kiefer", "Stumpf", "Will", "Karg", "Foerstner", "Zorn", "Linke",
    "Brockmann", "Kruegermann", "Degen", "Esslinger", "Graul", "Heyn", "Karger", "Strohmeyer", "Siering", "Pabst",
    "Hofer", "Reinke", "Weidemann", "Ertel", "Lohse", "Bayer", "Hentschel", "Pietsch", "Troschke", "Doelger",
    "Kleinschmidt", "Jungmann", "Beutel", "Aschenbrenner", "Kuehnel", "Lehner", "Schenk", "Walz", "Renneberg", "Kueck",
    "Bertram", "Koestner", "Boelter", "Hellmuth", "Steger", "Erhardt", "Klose", "Winkelmann", "Moehring", "Zech",
    "Weissmann", "Bruehl", "Rother", "Beier", "Nitsche", "Dittmann", "Wittmann", "Berndt", "Bruns", "Feuerstein",
    "Grundmann", "Habicht", "Kranz", "Petzold", "Reiss", "Rausch", "Sasse", "Teufel", "Wieland", "Zornow",
    "Klemens", "Thelen", "Vollmer", "Wetzel", "Preller", "Tischer", "Moehle", "Eisele", "Loesch", "Seng",
    "Brosch", "Hagedorn", "Thoma", "Hoefner", "Webermann", "Gerstenberg", "Poeppel", "Rinke", "Daeuble", "Lemke",
    "Paeschke", "Buchholz", "Jaksch", "Claassen", "Stange", "Friedel", "Spengler", "Trenner", "Wick", "Seligmann",
    "Orth", "Appenzeller", "Kromer", "Baenziger", "Gauger", "Plath", "Stange", "Hofstaetter", "Rettig", "Wahrlich",
    "Kleber", "Moos", "Burghardt", "Popp", "Naefen", "Kappler", "Schreckenberg", "Ziehl", "Altdorf", "Adler",
    "Boehler", "Kittel", "Engelmann", "Plietsch", "Timmann", "Volk", "Berghofer", "Haspel", "Niemann", "Vette",
    "Hagen", "Spoerl", "Wendt", "Drews", "Matheis", "Rothenberger", "Ehrlich", "Buelow", "Auer", "Renn",
    "Doetsch", "Neff", "Buettner", "Pfennig", "Dinklage", "Rothermel", "Handke", "Mues", "Balzer", "Wilde",
    "Kretschmann", "Brandes", "Hafner", "Geipel", "Henke", "Beckmann", "Bohn", "Haertel", "Eberle", "Kirchner",
    "Schollmeyer", "Schramke", "Schoettler", "Bruckner", "Zink", "Bieler", "Walther", "Vogt", "Weller", "Baumgaertner",
    "Seliger", "Prill", "Helbig", "Schnabel", "Graef", "Koenig", "Kuenstler", "Leu", "Strobl", "Freitag",
    "Bartz", "Ruehle", "Bessing", "Schuenemann", "Lehnert", "Heintz", "Mang", "Altenburg", "Fiedler", "Kaus",
    "Behrendt", "Niehaus", "Pfannschmidt", "Glaeser", "Krohn", "Hermes", "Dresel", "Wecker", "Weick", "Eibner",
    "Falkenberg", "Rauscher", "Greb", "Ringle", "Hoelzl", "Heckmann", "Stark", "Glaser", "Krey", "Lintner",
    "Kuenzel", "Tobien", "Gruening", "Lohwasser", "Reisinger", "Heiss", "Genz", "Kluge", "Tonn", "Blaschek",
    "Edelmann", "Reissner", "Wilke", "Dahmen", "Huelsmann", "Wickenheiser", "Rupprecht", "Trappe", "Poehlmann", "Wappler",
    "Binner", "Freimuth", "Ried", "Voelzing", "Wehrmann", "Hille", "Kronenberg", "Falkenstein", "Kolb", "Altenhofer",
    "Heldt", "Petersen", "Koester", "Wohlfarth", "Berninger", "Gauer", "Schmied", "Imhof", "Brock", "Heuck"
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

# Pfad zur OU _Sicherheit definieren
$sicherheitsgruppenPath = "OU=_Sicherheit,$grouppath"

foreach ($grp in $gruppen) {
    if (-not (Get-ADGroup -Filter {Name -eq $grp} -SearchBase $sicherheitsgruppenPath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $grp -GroupScope Global -GroupCategory Security -Path $sicherheitsgruppenPath
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
