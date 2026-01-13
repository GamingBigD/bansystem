# Bansystem

Ein umfassendes Ban-, Warn- und Jail-System für FiveM Server mit ESX Framework.

## Features

- **Ban System**
  - Spieler bannen mit individueller Dauer
  - Permanente Bans
  - Ban Templates für schnelles Bannen
  - Automatisches Unban nach Ablauf der Zeit
  - Ban History
  - Unban und Delete Ban Funktionen

- **Warn System**
  - Spieler verwarnen
  - Warn Templates
  - Automatischer Ban nach X Verwarnungen
  - Warn History

- **Jail System**
  - Spieler in Admin-Jail stecken
  - Jail Templates
  - Automatische Freilassung nach Ablauf der Zeit
  - Spieler können Jail-Bereich nicht verlassen

- **Discord Logging**
  - Alle Aktionen werden in Discord geloggt
  - Separate Webhooks für verschiedene Aktionen

## Installation

1. Extrahiere den Ordner in dein `resources` Verzeichnis
2. Importiere die `install.sql` in deine Datenbank
3. Füge `ensure ov_bansystem` zu deiner `server.cfg` hinzu
4. Konfiguriere die `config.lua` nach deinen Wünschen

## Konfiguration

### config.lua
- Notification System anpassen
- Discord Webhooks eintragen
- Berechtigungen anpassen

### shared/sh_config.lua
- Jail Position ändern
- Admin Gruppen definieren
- Ban/Warn/Jail Templates anpassen
- Max Warns vor Auto-Ban einstellen

## Befehle

### Ban Commands
- `/ban [id] [dauer] [grund]` - Spieler bannen (Dauer in Minuten, -1 = permanent)
- `/bantemplate [id] [templateId]` - Spieler mit Template bannen
- `/unban [banId/license]` - Spieler entbannen
- `/delban [banId]` - Ban löschen

### Warn Commands
- `/warn [id] [grund]` - Spieler verwarnen
- `/warntemplate [id] [templateId]` - Spieler mit Template verwarnen

### Jail Commands
- `/jail [id] [dauer] [grund]` - Spieler in Jail stecken (Dauer in Minuten)
- `/jailtemplate [id] [templateId]` - Spieler mit Template in Jail stecken
- `/unjail [id] [grund]` - Spieler aus Jail holen

## Berechtigungen

Alle Commands können nur von Spielern mit Admin-Rechten verwendet werden.
Die Admin Gruppen können in `shared/sh_config.lua` definiert werden.

Standard Admin Gruppen:
- admin
- superadmin
- mod

## Dependencies

- es_extended (ESX Framework)
- oxmysql (MySQL Async)

## Support

Bei Fragen oder Problemen erstelle bitte ein Issue auf GitHub.

## License

MIT License
