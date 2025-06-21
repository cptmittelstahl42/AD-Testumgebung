🛠️ AD-Testuser-Skripte
Dieses Repository enthält PowerShell-Skripte zur automatisierten Einrichtung einer Active Directory-Struktur – ideal für Lab-Setups, Schulungen oder Systemtests. Es erstellt OUs, Benutzer, Gruppen und füllt diese mit realistischen Testdaten.

🚀 Funktionen des Hauptskripts (ad-setup.ps1)
Erstellung einer vollständigen OU-Struktur inkl. User, Gruppen, Server, Projekte etc.

Anlage von Gruppen wie Marketing, Vertrieb, Vorstand etc.

Benutzer mit zufälligem Vor- und Nachnamen

Automatische Gruppenverteilung (Vorstand auf max. 4 Mitglieder begrenzt)

Zuweisung realistischer Benutzerattribute:

Adresse: Musterstraße 12, Hamburg, 20095

Telefonnummer: zufällige Durchwahl +49 40 1234-####

Titel, Abteilung, Initialen, Beschreibung etc.

💻 Verwendung
Das Skript kann direkt über PowerShell aus GitHub/GitLab ausgeführt werden:

powershell
Invoke-RestMethod -Uri "https://raw.githubusercontent.com/cptmittelstahl42/AD-Testumgebung/refs/heads/main/ad-setup.ps1" | Invoke-Expression
Alternativ zum Download:

powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/cptmittelstrahl42/AD-Testumgebung/main/ad-setup.ps1" -OutFile "$env:TEMP\ad-setup.ps1"

🧩 Voraussetzungen
PowerShell mit Administratorrechten

Active Directory Modul (Import-Module ActiveDirectory)

Ausführung auf einem Domain Controller oder Domänenmitglied mit passenden Rechten


Weitere nützliche Skripte 

1. add-homefolders.ps1
Erstellt automatische Home-Verzeichnisse auf einem Fileserver mit NTFS-Berechtigungen basierend auf Benutzern in der User-OU.

2. report-export.ps1
Exportiert eine CSV-Liste aller Testuser mit Attributen wie:

Name

SamAccountName

Gruppe

Telefonnummer

Abteilung

Perfekt für Audits oder zur Weitergabe an Admin-Kollegen.

3. cleanup-lab.ps1
Optionales Rollback-Skript, das alle erstellten Testobjekte (OUs, User, Gruppen) wieder entfernt – nützlich für Labs oder Demos.
