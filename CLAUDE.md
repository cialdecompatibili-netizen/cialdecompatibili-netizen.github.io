sito https://cialdecompatibili-netizen.github.io/

# CLAUDE.md — Jekyll + GitHub Pages (cialdecompatibili-netizen)

## REGOLA: GIT AUTOMATICO
- INIZIO sessione: Claude fa SEMPRE git pull via Desktop Commander PRIMA di leggere qualsiasi file
- FINE modifiche: Claude chiede a Mirco "✅ Tutto fatto! Pusho su GitHub?" e aspetta si/no
- Se Mirco dice si: Claude fa git add + commit + push automatico, nessun click richiesto
- Comando pull: cd "C:\Users\mirco\Desktop\Jekyll + GitHub" ; git pull origin main
- Comando push: cd "C:\Users\mirco\Desktop\Jekyll + GitHub" ; git add . ; git commit -m aggiornamento ; git push
- Se il push fallisce (rejected): fare pull --rebase poi push di nuovo
- Comando push+rebase: cd "C:\Users\mirco\Desktop\Jekyll + GitHub" ; git pull origin main --rebase ; git push
- NON toccare mai 2-PUBBLICA.bat e NON toccare mai 3-PULL.bat — sono di Mirco

## REGOLA META — AGGIORNAMENTO AUTOMATICO
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
### PROBLEMA: Editor visuale vuoto quando si clicca Modifica articolo
- SINTOMO: Clicchi "Modifica" su un articolo, il testo appare solo in Markdown.
  Se sei in modalita' Visuale il vis-editor e' vuoto. Passando da Markdown a Visuale il testo sparisce.
- CAUSA: modificaArticolo() scriveva il corpo solo nel textarea, non nel vis-editor.
- SOLUZIONE: Sostituire document.getElementById('corpo').value=body con setCorpo(body).
  La funzione setCorpo() aggiorna sia il textarea che il vis-editor insieme.

---
### FUNZIONALITA': Eliminazione articoli dal CMS
- DOVE: Tab "Articoli" → lista "Pubblicati" → pulsante 🗑️ Elimina
- COME: Chiede conferma, poi chiama API GitHub DELETE con path + sha del file
- AGGIORNAMENTO: La lista si ricarica automaticamente dopo l'eliminazione
- FUNZIONE JS: eliminaArticolo(path, sha, nome) in admin/index.html
- SHA: viene passato direttamente da caricaLista() tramite f.sha restituito dall'API GitHub

## PRIMA DI INIZIARE OGNI SESSIONE
1. Leggi questo file — non chiedere "di che progetto si tratta".
2. Menu -> solo _data/navigation.yml.
3. Layout custom -> no nav/footer dentro.
4. Home = index.html, Blog = _pages/blog.md — separati.
5. Deploy = doppio click su 2-PUBBLICA.bat.
6. CMS = solo admin/ — niente cms/ o altre cartelle.
7. Se risolvi un problema nuovo -> aggiorna SOLUZIONI GIA' RISOLTE qui sopra.
