@echo off
cd /d "%~dp0"
git add .
git commit -m aggiornamento
git push
echo Fatto! Sito live in 60 secondi.
pause