# Buchhaltung PWA mit Supabase Backend

Mobile Buchungs-App mit Login, Supabase-Datenbank, Dropdowns, Auswertungen, CSV-Export und JSON-Backup/Import.

## 1. Supabase-Projekt erstellen

1. Auf supabase.com ein Projekt erstellen.
2. Authentication > Providers > Email aktivieren.
3. Optional: E-Mail-Bestätigung deaktivieren, wenn du sofort testen willst.
4. SQL Editor öffnen und den Inhalt von `supabase-schema.sql` ausführen.

## 2. App konfigurieren

Öffne `config.js` und ersetze die Platzhalter:

```js
export const SUPABASE_URL = 'https://dein-projekt.supabase.co';
export const SUPABASE_ANON_KEY = 'dein-publishable-oder-anon-key';
```

Die Werte findest du in Supabase unter Project Settings > API.

## 3. Lokal testen

Weil die App JavaScript-Module verwendet, nicht direkt per Doppelklick öffnen. Im Ordner starten:

```bash
python3 -m http.server 8080
```

Dann öffnen:

```text
http://localhost:8080
```

Alternative mit Node:

```bash
npx serve .
```

## 4. Online stellen

Einfachste Varianten:

- Netlify: Ordner per Drag & Drop deployen.
- Vercel: GitHub-Repository verbinden.
- eigener Webserver: alle Dateien hochladen.

Wichtig: `config.js` muss vor dem Deploy deine Supabase-Werte enthalten.

## 5. Handy nutzen

Website im Handy-Browser öffnen und über das Browser-Menü zum Home-Bildschirm hinzufügen.

## Hinweise

- Buchungen sind pro Login getrennt. Row Level Security ist in `supabase-schema.sql` aktiviert.
- Belegfotos werden aktuell als kleine Base64-Daten in der Tabelle gespeichert. Für viele/grosse Belege wäre Supabase Storage sauberer.
- Der CSV-Export exportiert die aktuell gefilterte Liste.
- JSON-Backup/Import kann für Migration oder Datensicherung genutzt werden.
