@echo off
cd /d "%~dp0"
git pull origin main
echo Aggiornato! Repository locale sincronizzata.
pause