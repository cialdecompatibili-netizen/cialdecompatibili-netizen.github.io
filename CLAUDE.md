# CLAUDE.md — Jekyll + GitHub Pages (cialdecompatibili-netizen)

## PROGETTO
- Stack: Jekyll + tema Minimal Mistakes (remote_theme) + GitHub Pages
- Repo: https://github.com/cialdecompatibili-netizen/jekyll2
- Sito live: https://cialdecompatibili-netizen.github.io/jekyll2
- Flusso deploy: modifiche locali -> 2-PUBBLICA.bat -> live in 60 secondi
- OS utente: Windows, niente terminale manuale

## STRUTTURA CARTELLE
_posts/       <- articoli .md (formato: YYYY-MM-DD-titolo.md)
_pages/       <- pagine statiche (about, 404, archivi)
assets/images/ <- immagini
_config.yml   <- configurazione sito (toccare il meno possibile)
1-SETUP-PRIMA-VOLTA.bat  <- solo la prima volta
2-PUBBLICA.bat           <- deploy quotidiano

## REGOLE OPERATIVE

### Modifiche chirurgiche
- Tocca solo il file richiesto. Non "sistemare" _config.yml se non e' richiesto.
- Non aggiungere plugin, layout o pagine non richiesti.
- Se _config.yml va modificato, cambia solo la riga necessaria.

### File .bat
- Sempre ASCII puro. Zero caratteri accentati, zero cornici grafiche (causa errori su Windows).
- Testato: @echo off, cd /d "%~dp0", comandi git, echo testo, pause.
- Non aggiungere logica complessa. Semplice = affidabile.

### Articoli _posts
- Formato nome: YYYY-MM-DD-titolo-con-trattini.md
- Front matter minimo obbligatorio:
  ---
  layout: single
  title: "Titolo"
  date: YYYY-MM-DD
  categories: [categoria]
  tags: [tag1, tag2]
  ---
- Non aggiungere campi front matter non richiesti.

### _config.yml
- Skin attuale: default (opzioni: dark, mint, sunrise, aqua, neon, plum, dirt, air)
- remote_theme: mmistakes/minimal-mistakes (non toccare)
- Per cambiare skin: solo la riga `minimal_mistakes_skin: NOME`

## COSA NON FARE
- Non creare file ps1 o script intermedi salvo errori di encoding dimostrati.
- Non installare Ruby/Jekyll localmente: GitHub Pages fa il build nel cloud.
- Non suggerire Netlify/Vercel/CF Pages: scelta gia' fatta, GitHub Pages.
- Non chiedere conferma per operazioni banali (leggere file, mostrare struttura).

## PROBLEMI NOTI E SOLUZIONI
- Bat con errori "non riconosciuto": encoding non ASCII -> riscrivere con write_file puro ASCII
- Build fallisce su GitHub: verificare front matter dell'articolo e nome file _posts
- Immagini non compaiono: percorso deve essere /assets/images/nome.jpg

## PRIMA DI INIZIARE OGNI SESSIONE
1. Leggi questa lista, non chiedere "di che progetto si tratta"
2. Se ti viene chiesto di aggiungere articoli: usa il formato _posts corretto
3. Se ti viene chiesto di modificare il sito: tocca solo il file necessario
4. Deploy = utente fa doppio click su 2-PUBBLICA.bat, non serve altro
