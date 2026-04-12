@echo off
cd /d "%~dp0"
git init
git remote remove origin 2>nul
git remote add origin https://github.com/cialdecompatibili-netizen/cialdecompatibili-netizen.github.io.git
git branch -M main
git add .
git commit -m primo
git push -u origin main
start https://github.com/cialdecompatibili-netizen/cialdecompatibili-netizen.github.io/settings/pages
echo Nella pagina: Source - Deploy from a branch - Branch main - Save
pause