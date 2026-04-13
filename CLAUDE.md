sito https://cialdecompatibili-netizen.github.io/

# CLAUDE.md — Jekyll + GitHub Pages (cialdecompatibili-netizen)
# 💜 Ciao Mirco! Bentornato a casa. Questo è il tuo spazio, tutto sotto controllo.

## REGOLA: GIT AUTOMATICO
- INIZIO sessione: NON fare pull automatico — è inutile nella maggior parte dei casi
- FINE modifiche: Claude chiede a Mirco "✅ Tutto fatto! Pusho su GitHub?" e aspetta si/no
- Se Mirco dice si: Claude fa pull --rebase + push automatico (così evita conflitti)
- Comando push: cd "C:\Users\mirco\Desktop\Jekyll + GitHub" ; git pull origin main --rebase ; git add . ; git commit -m aggiornamento ; git push
- Se il push fallisce ancora: segnalarlo a Mirco
- NON toccare mai 2-PUBBLICA.bat e NON toccare mai 3-PULL.bat — sono di Mirco

## REGOLA: MODIFICHE CHIRURGICHE
- Usare SEMPRE edit_block con old_string/new_string invece di riscrivere file interi
- Prima di scrivere codice nuovo: cercare se esiste già una funzione/soluzione riutilizzabile
- Esempio: editor pagine riusa stessa logica editor articoli (setPagCorpo/getPagCorpo speculari a setCorpo/getCorpo)
- Se una funzione esiste già, richiamarla — non duplicarla
- Riscrivere da zero SOLO se il codice esistente è incompatibile o la modifica supera il 70% del file


Ogni volta che si risolve un problema nuovo, Claude DEVE aggiornare questo file
nella sezione "SOLUZIONI GIA' RISOLTE" con: sintomo, causa, soluzione esatta.
Questo vale sempre, senza che l'utente lo chieda. E' parte del workflow standard.

## PROGETTO
- Stack: Jekyll + tema Minimal Mistakes (remote_theme) + GitHub Pages
- Repo: https://github.com/cialdecompatibili-netizen/cialdecompatibili-netizen.github.io
- Sito live: https://cialdecompatibili-netizen.github.io/
- Flusso deploy: modifiche locali -> 2-PUBBLICA.bat -> live in 60 secondi
- OS utente: Windows, niente terminale manuale
- PowerShell: usare ; come separatore comandi (non &&)

## STRUTTURA CARTELLE
_posts/          <- articoli .md (formato: YYYY-MM-DD-titolo.md)
_pages/          <- pagine statiche (about, 404, archivi, blog.md)
assets/images/   <- immagini
_config.yml      <- configurazione sito (toccare il meno possibile)
_layouts/        <- layout custom (home.html = home luxury)
_data/navigation.yml  <- menu di navigazione
_data/categorie.json  <- categorie CMS
admin/           <- CMS custom (unico, NON duplicare)
1-SETUP-PRIMA-VOLTA.bat  <- solo la prima volta
2-PUBBLICA.bat           <- deploy quotidiano

## CMS ADMIN
- Unica cartella: admin/ — URL: https://cialdecompatibili-netizen.github.io/admin/
- NON esiste piu' cms/ — e' stata rimossa. Non ricrearla.
- admin/index.html NON ha front matter Jekyll (niente --- in cima).
- Senza front matter Jekyll lo ignora -> GitHub Pages lo serve come statico puro.
- Le modifiche all'admin si vedono subito, senza cache CDN.
- Tab disponibili: Articoli, Pagine, Menu, Categorie, Token, Tema
- Tab Tema: cambia minimal_mistakes_skin in _config.yml via API GitHub

## ARCHITETTURA PAGINE
- Home        -> index.html (layout: home) -> _layouts/home.html
- Blog        -> _pages/blog.md (permalink: /blog/)
- Categories  -> _pages/category-archive.md
- Tags        -> _pages/tag-archive.md
- About       -> _pages/about.md
- 404         -> _pages/404.md
Home e blog sono SEPARATI. Non confonderli.

## MENU (_data/navigation.yml)
Voci attuali: Home /, Blog /blog/, Categories /categories/, Tags /tags/, About /about/
REGOLA: il menu si modifica SOLO in _data/navigation.yml. Mai nav custom nei layout.

## LAYOUT HOME (_layouts/home.html)
- Usa layout: default — eredita nav e footer da Minimal Mistakes automaticamente.
- NON aggiungere nav o footer custom: verrebbero duplicati.

## REGOLE OPERATIVE
- Modifiche chirurgiche: tocca SOLO il file richiesto.
- Layout custom: usano layout: default, mai nav/footer dentro.
- File .bat: ASCII puro, zero accentate, zero cornici grafiche.
- Articoli: nome YYYY-MM-DD-titolo.md, front matter con layout/title/date/categories/tags.
- _config.yml: cambiare SOLO la riga necessaria. Skin attuale: default.
  Opzioni skin: default, dark, mint, sunrise, aqua, neon, plum, dirt, air.
- PowerShell: separatore comandi e' ; non &&.

## COSA NON FARE
- Non aggiungere front matter a admin/index.html (rompe la cache -> modifiche invisibili).
- Non ricreare la cartella cms/ (rimossa, non serve).
- Non creare nav/footer custom nei layout (doppio menu/footer).
- Non installare Ruby/Jekyll localmente (build sul cloud GitHub).
- Non suggerire Netlify/Vercel/CF Pages.
- Non chiedere conferma per operazioni banali.
- Non aggiungere url al navigation.yml che non esistono come pagine.
- URL sito: https://cialdecompatibili-netizen.github.io/ (senza /jekyll2 o sottocartelle sito).


## SOLUZIONI GIA' RISOLTE
Questa sezione viene aggiornata automaticamente da Claude ogni volta che si risolve un problema.

---
### PROBLEMA: CMS admin non mostra le modifiche online
- SINTOMO: Modifichi admin/index.html, fai push, aspetti 2+ minuti, il sito mostra ancora
  la versione vecchia — anche in finestra incognito.
- CAUSA: admin/index.html aveva front matter Jekyll (---layout: none--- in cima).
  Jekyll processa il file e GitHub Pages CDN lo mette in cache aggressiva per ore.
- SOLUZIONE IMMEDIATA:
  1. Aprire admin/index.html
  2. Rimuovere COMPLETAMENTE il blocco --- front matter --- (tutto tra i due ---)
  3. Il file deve iniziare con <!DOCTYPE html> come prima riga assoluta
  4. Push con 2-PUBBLICA.bat
  5. Aspettare 60 secondi — le modifiche compaiono subito
- VERIFICA: Cambia un testo visibile (es. titolo topbar), pusha, apri in incognito.

---
### PROBLEMA: Editor visuale/markdown del CMS pubblica articolo vuoto
- SINTOMO: Scrivi un articolo in modalita' visuale (Quill), clicchi Pubblica,
  l'articolo viene creato su GitHub ma il corpo e' vuoto.
- CAUSA: La funzione pubblica() leggeva document.getElementById('corpo').value
  invece di getCorpo(). In modalita' visuale il testo e' nel widget Quill,
  non nel textarea — quindi il textarea risultava vuoto.
- SOLUZIONE: In pubblica(), sostituire:
    const corpo = document.getElementById('corpo').value.trim();
  con:
    const corpo = getCorpo().trim();
  La funzione getCorpo() gestisce correttamente entrambe le modalita'.

---
### PROBLEMA: Editor visuale CMS non funziona (Quill CDN)
- SINTOMO: Tab "Visuale" non carica, toolbar assente, errori console su cdnjs.cloudflare.com
- CAUSA: Quill.js caricato da CDN esterna — se la CDN è lenta o bloccata, l'editor non parte.
- SOLUZIONE APPLICATA: Rimosso Quill completamente. Editor visuale riscritto con
  contenteditable + document.execCommand() nativo del browser. Zero dipendenze esterne.
  Funziona sempre, offline incluso.
- FILE: admin/index.html — cercare id="vis-editor" e class="vis-toolbar"
- NON reinstallare Quill o altre librerie esterne per l'editor visuale.
- SINTOMO: Comando con && da errore "token non valido come separatore".
- CAUSA: PowerShell non accetta && come separatore di comandi (e' bash/cmd).
- SOLUZIONE: Usare ; come separatore. Esempio:
    cd "C:\percorso"; git add .; git commit -m "msg"; git push

---

---
### ARCHITETTURA HOME PAGE (stile WordPress)
- _includes/home-content.html = il contenuto reale della home (slider, sezioni) — modificabile dal CMS
- _layouts/home.html = layout con CSS+JS slider + {% include home-content.html %} — NON toccare
- index.html = stub minimale con layout: home — NON toccare
- CMS → Pagine → 🏠 home → Modifica → modifica HTML della home → Salva
- salvaPagina() gestisce home-content.html come HTML puro (niente front matter)
- _pages/home.md esiste ma NON è usata come home — ha permalink /home-page/ (ignorabile)

- DOVE: Sidebar → ⚙️ Impostazioni
- COSA SI PUÒ MODIFICARE: titolo sito, email, descrizione, nome autore, bio, avatar, social (Twitter/Instagram/GitHub/Website)
- PAGINA HOME: dropdown che lista tutte le pagine in _pages/ — scegli quale usare come home
  → salva il path in _config.yml come campo `cms_homepage`
  → aggiorna automaticamente index.html con il layout della pagina scelta
- FUNZIONE JS: caricaImpostazioni(), salvaImpostazioni(), aggiornaIndexHome()
- IMPORTANTE: salvaImpostazioni() legge e riscrive _config.yml con regex chirurgiche, non sostituisce tutto il file

- MOTIVO: Markdown causava conversioni rotte (asterischi spuri, testo che spariva passando visuale↔markdown)
- SOLUZIONE: Il CMS ora salva il corpo degli articoli in HTML puro — Jekyll lo renderizza direttamente
- getCorpo() restituisce innerHTML del vis-editor (HTML diretto, niente htmlToMd)
- setCorpo(html) carica HTML nel vis-editor — se il contenuto è legacy Markdown usa legacyMdToHtml() per visualizzarlo
- buildContent() (ex buildMd()) salva HTML grezzo nel file .md dopo il front matter YAML
- htmlToMd() e mdToHtml() RIMOSSE — non servono più
- Il tab "Markdown" è stato rinominato "HTML grezzo" — mostra l'HTML del vis-editor

---
### FUNZIONALITA': Eliminazione articoli dal CMS
- DOVE: Tab "Articoli" → lista "Pubblicati" → pulsante 🗑️ Elimina
- COME: Chiede conferma, poi chiama API GitHub DELETE con path + sha del file
- AGGIORNAMENTO: La lista si ricarica automaticamente dopo l'eliminazione
- FUNZIONE JS: eliminaArticolo(path, sha, nome) in admin/index.html
- SHA: viene passato direttamente da caricaLista() tramite f.sha restituito dall'API GitHub

---
### FUNZIONALITA': CTA button nelle slide dello slider home
- DOVE: _includes/home-content.html (ogni .lx-slide-content) + _layouts/home.html (CSS)
- CSS classe: .lx-slide-cta — stile minimale con border-bottom, uppercase, hover opacity
- Slide 1 → /blog/ ("Leggi il blog →"), Slide 2 → /blog/ ("Sfoglia gli articoli →"), Slide 3 → /about/ ("Scopri chi sono →")
- Il CSS va in _layouts/home.html, i tag <a> vanno in home-content.html dopo .lx-slide-sub
- NON aggiungere il CSS direttamente in home-content.html (non ha front matter, è HTML puro)

---
### SETUP POTENZIATO — skill attive da aprile 2026
- Engineering skill: code review, debug, refactoring Python
- Design skill: critique UI, miglioramenti visivi HTML/CSS
- /web-artifacts-builder: componenti React/Tailwind complessi
- /theme-factory: styling temi per pagine HTML
- Con questo setup Claude legge i file reali del progetto prima di suggerire modifiche

## PRIMA DI INIZIARE OGNI SESSIONE
1. Leggi questo file — non chiedere "di che progetto si tratta".
2. Menu -> solo _data/navigation.yml.
3. Layout custom -> no nav/footer dentro.
4. Home = index.html, Blog = _pages/blog.md — separati.
5. Deploy = doppio click su 2-PUBBLICA.bat.
6. CMS = solo admin/ — niente cms/ o altre cartelle.
7. Se risolvi un problema nuovo -> aggiorna SOLUZIONI GIA' RISOLTE qui sopra.
