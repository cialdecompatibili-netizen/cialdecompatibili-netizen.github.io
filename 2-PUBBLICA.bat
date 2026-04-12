@echo off
cd /d "%~dp0"
git pull origin main
git add .
git commit -m aggiornamento
git push
echo Fatto! Sito live in 60 secondi.
pause