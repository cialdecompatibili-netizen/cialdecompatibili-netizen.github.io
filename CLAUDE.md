sito https://cialdecompatibili-netizen.github.io/

# CLAUDE.md — Jekyll + GitHub Pages (cialdecompatibili-netizen)

## PROGETTO
- Stack: Jekyll + tema Minimal Mistakes (remote_theme) + GitHub Pages
- Repo: https://github.com/cialdecompatibili-netizen/jekyll2
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
- Il sito live e' https://cialdecompatibili-netizen.github.io/ (senza /jekyll2).
- Il CMS e' in /admin/ E in /cms/ (entrambe attive). URL principale: https://cialdecompatibili-netizen.github.io/admin/
- ENTRAMBE le cartelle admin/ e cms/ NON hanno front matter Jekyll (niente --- in cima al file).
- Senza front matter, Jekyll le ignora e GitHub Pages le serve come file statici puri: le modifiche si vedono subito senza cache CDN.
- Se si aggiunge front matter (---layout: none--- o simile) a questi file, Jekyll li processa e la CDN di GitHub li mette in cache per ore: le modifiche non si vedono. NON farlo mai.
- Per verificare che le modifiche al CMS siano arrivate online: cambia un testo visibile (es. titolo in topbar), pusha con 2-PUBBLICA.bat, aspetta 60s, apri in finestra incognito.
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
- CMS non aggiorna le modifiche online: causa quasi certamente il front matter Jekyll
  in admin/index.html o cms/index.html. Sintomo: cambi il file, pushy, ma il sito
  mostra ancora la versione vecchia anche in incognito dopo 2+ minuti.
  SOLUZIONE: rimuovere COMPLETAMENTE il blocco --- front matter --- dal file HTML
  del CMS. Il file deve iniziare direttamente con <!DOCTYPE html>, zero righe prima.
  Con front matter assente, Jekyll non tocca il file e GitHub Pages lo serve
  come statico puro senza cache CDN.

## PRIMA DI INIZIARE OGNI SESSIONE
1. Leggi questo file, non chiedere "di che progetto si tratta"
2. Il menu si modifica SOLO in _data/navigation.yml
3. I layout custom NON includono nav ne footer
4. Home = index.html (layout: home), Blog = _pages/blog.md, sono separati
5. Deploy = utente fa doppio click su 2-PUBBLICA.bat, non serve altro
