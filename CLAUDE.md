sito https://cialdecompatibili-netizen.github.io/

# CLAUDE.md — Jekyll + GitHub Pages (cialdecompatibili-netizen)

## PROGETTO
- Stack: Jekyll + tema Minimal Mistakes (remote_theme) + GitHub Pages
- Repo: https://github.com/cialdecompatibili-netizen/cialdecompatibili-netizen.github.io
- Sito live: https://cialdecompatibili-netizen.github.io/
- Flusso deploy: modifiche locali -> 2-PUBBLICA.bat -> live in 60 secondi
- OS utente: Windows, niente terminale manuale

## STRUTTURA CARTELLE
_posts/       <- articoli .md (formato: YYYY-MM-DD-titolo.md)
_pages/       <- pagine statiche (about, 404, archivi, blog.md)
assets/images/ <- immagini
_config.yml   <- configurazione sito (toccare il meno possibile)
_layouts/     <- layout custom (home.html = home luxury)
_data/navigation.yml <- menu di navigazione
1-SETUP-PRIMA-VOLTA.bat  <- solo la prima volta
2-PUBBLICA.bat           <- deploy quotidiano

## ARCHITETTURA PAGINE
- Home        -> index.html (layout: home) -> _layouts/home.html
- Blog        -> _pages/blog.md (permalink: /blog/) layout custom con lista post
- Categories  -> _pages/category-archive.md
- Tags        -> _pages/tag-archive.md
- About       -> _pages/about.md
- 404         -> _pages/404.md

La home e il blog sono SEPARATI e DISTINTI. Non confonderli.

## MENU NAVIGAZIONE (_data/navigation.yml)
Il menu attuale e':
  - Home        /
  - Blog        /blog/
  - Categories  /categories/
  - Tags        /tags/
  - About       /about/

REGOLA CRITICA: Non inventare mai un nav custom nei layout.
Il nav lo gestisce SEMPRE Minimal Mistakes tramite _data/navigation.yml.
Modificare solo navigation.yml per cambiare voci del menu.


## LAYOUT HOME (_layouts/home.html)
- Usa layout: default (eredita nav e footer da Minimal Mistakes)
- Contiene SOLO il contenuto: hero, strip contatori, griglia 3 post
- NON ha nav custom, NON ha footer custom — li fornisce gia' Minimal Mistakes
- Se si aggiunge un nav custom dentro home.html si creano 2 nav sovrapposti -> ERRORE

## REGOLE OPERATIVE

### Modifiche chirurgiche
- Tocca solo il file richiesto. Non "sistemare" _config.yml se non e' richiesto.
- Non aggiungere plugin, layout o pagine non richiesti.
- Se _config.yml va modificato, cambia solo la riga necessaria.

### Layout custom
- I layout custom in _layouts/ usano layout: default come base
- NON includere mai nav o footer nei layout custom: li gestisce Minimal Mistakes
- Il contenuto del layout va dentro il <body> che default gia' fornisce

### File .bat
- Sempre ASCII puro. Zero caratteri accentati, zero cornici grafiche.
- Testato: @echo off, cd /d "%~dp0", comandi git, echo testo, pause.
- Non aggiungere logica complessa.

### Pagine _pages
- Le pagine esistenti si modificano dal pannello admin -> Pagine -> ✏️ Modifica
- Le pagine nuove si creano dal pannello admin -> Pagine -> ✚ Nuova pagina
- Campi: Titolo, Permalink (es. /contatti/), Contenuto Markdown
- Il file viene creato automaticamente in _pages/slug.md via GitHub API
- Dopo la creazione, aggiungere la voce al menu in _data/navigation.yml


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
- Non creare nav custom dentro i layout -> doppio menu
- Non creare footer custom dentro i layout -> doppio footer
- Non installare Ruby/Jekyll localmente: GitHub Pages fa il build nel cloud.
- Non suggerire Netlify/Vercel/CF Pages: scelta gia' fatta, GitHub Pages.
- Non chiedere conferma per operazioni banali (leggere file, mostrare struttura).
- Non modificare navigation.yml aggiungendo url che non esistono come pagine.

## PROBLEMI NOTI E SOLUZIONI
- Doppio nav/menu: qualcuno ha aggiunto un nav custom in un layout -> rimuoverlo
- Bat con errori "non riconosciuto": encoding non ASCII -> riscrivere ASCII puro
- Build fallisce su GitHub: verificare front matter articolo e nome file _posts
- Immagini non compaiono: percorso deve essere /assets/images/nome.jpg

## PANNELLO ADMIN (/admin/)

### Posizione file
- Il file admin si trova in `_pages/admin.html` (NON in `admin/index.html`)
- Front matter obbligatorio:
  ---
  layout: none
  permalink: /admin/
  published: true
  ---
- CRITICO: il file DEVE stare in `_pages/` altrimenti Jekyll lo copia come
  file statico nella _site/ senza processarlo, e GitHub Pages serve la versione
  CDN-cached senza mai rigenerarla.

### Editor visuale (senza dipendenze esterne)
- L'editor usa contenteditable nativo + execCommand, ZERO librerie CDN
- NON usare Quill, TinyMCE o altre librerie esterne: non si caricano in modo affidabile
- Struttura HTML dell'editor:
    <div id="ve-box">
      <div class="ve-toolbar"> ... bottoni con onmousedown ... </div>
      <div id="ve-body" class="ve-body" contenteditable="true"></div>
    </div>
    <textarea id="corpo" style="display:none"></textarea>
- I bottoni della toolbar DEVONO usare `onmousedown="event.preventDefault();..."`
  (NON onclick) altrimenti il click fa perdere il focus al contenteditable e i
  comandi non funzionano
- Switch visuale/markdown gestito da `switchEditor(mode)` con variabile `_editorMode`

### Problema cache GitHub Pages (IMPORTANTE)
- Se GitHub Pages serve una versione vecchia dell'admin anche dopo i push:
  1. Il file admin era in `admin/index.html` invece che in `_pages/admin.html`
     -> Jekyll lo copiava come statico senza rigenerarlo mai
  2. Soluzione definitiva: spostare in `_pages/admin.html` con layout: none
  3. Se la cache persiste su /admin/ anche dopo lo spostamento:
     -> Temporaneamente cambiare permalink in /cms/ e pushare
     -> Verificare che /cms/ funzioni (dimostra che Jekyll builda correttamente)
     -> Rimettere permalink: /admin/ e pushare di nuovo
     -> GitHub Pages crea la pagina da zero senza cache vecchia
- Questo approccio "bypass cache via permalink temporaneo" è testato e funziona.

## PRIMA DI INIZIARE OGNI SESSIONE
1. Leggi questo file, non chiedere "di che progetto si tratta"
2. Il menu si modifica SOLO in _data/navigation.yml
3. I layout custom NON includono nav ne footer
4. Home = index.html (layout: home), Blog = _pages/blog.md, sono separati
5. Deploy = utente fa doppio click su 2-PUBBLICA.bat, non serve altro
