# ParSec Nova - Übersetzungs-Anforderungen

## Aktueller Status
Alle Spieltexte sind derzeit auf Deutsch und müssen für die internationale Veröffentlichung übersetzt werden.

## Text-Elemente, die Übersetzung benötigen

### HUD-Anzeige (TestControls.gd)
- **Schiff-Daten Bereich:**
  - "=== SCHIFF-DATEN ==="
  - "Geschwindigkeit: %.1f m/s"
  - "Geschw. Vektor: (%.1f, %.1f, %.1f)"
  - "[F1 für Hilfe]"

- **Drehraten Bereich:**
  - "=== DREHRATEN ==="
  - "X-Achse (Pitch): %.3f rad/s"
  - "Y-Achse (Yaw): %.3f rad/s"
  - "Z-Achse (Roll): %.3f rad/s"

- **Objekte Bereich:**
  - "=== OBJEKTE ==="
  - "Sonne Distanz: %.1f m"
  - "Asteroid Distanz: %.1f m"

### Hilfe-Dialog (TestControls.gd)
- **Titel und Bereiche:**
  - "=== TASTENBELEGUNGEN ==="
  - "BEWEGUNG:"
  - "SONDERFUNKTIONEN:"
  - "ANZEIGE:"

- **Bewegungs-Steuerung:**
  - "Pfeil hoch/runter     - Schiff neigen (Pitch)"
  - "Pfeil links/rechts   - Schiff drehen (Yaw)"
  - "Leertaste            - Vorwärts schubsen"
  - "Umschalt+Leertaste   - Rückwärts schubsen"

- **Sonderfunktionen:**
  - "S                    - Notstopp (alle Bewegung)"
  - "F1                   - Diese Hilfe ein/aus"
  - "ESC                  - Spiel beenden"

- **Anzeige-Informationen:**
  - "HUD links oben zeigt Echtzeitdaten"
  - "Geschwindigkeit, Drehraten, Distanzen"
  - "Drücke F1 um Hilfe zu schließen"

### Konsolen-Meldungen (TestControls.gd)
- "Hilfe angezeigt"
- "Hilfe versteckt"
- "Emergency stop activated - All ship movement stopped!"

## Übersetzungs-Strategie
1. **Alle Text-Strings extrahieren** in ein zentrales Übersetzungssystem
2. **Mehrere Sprachen unterstützen** (Englisch, Deutsch, potenziell weitere)
3. **Sprachwechsel-Funktionalität** in Spieleinstellungen
4. **Fallback auf Deutsch** wenn Übersetzung fehlt
5. **Lokalisierung berücksichtigen** für Zahlenformate, Datum/Uhrzeit falls benötigt

## Implementierungs-Hinweise
- Godot's eingebautes Übersetzungssystem verwenden
- Separate Übersetzungsdateien für jede Sprache erstellen
- Laufzeit-Sprachwechsel implementieren
- Alle UI-Elemente mit verschiedenen Textlängen testen
- Sicherstellen, dass Hilfe-Dialog-Formatierung mit übersetztem Text funktioniert

## Priorität
Mittel - Wichtig für internationale Erreichbarkeit, aber nicht für aktuelle Entwicklung blockierend.
