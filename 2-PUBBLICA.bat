@echo off
cd /d "%~dp0"
git pull --rebase
git add .
git commit -m aggiornamento
git push
echo Fatto! Sito live in 60 secondi.
pause