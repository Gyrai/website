@echo off
rem Publishes this folder as the public GitHub Pages site for gyrai.org.
rem Prerequisites: the GitHub organization "gyrai" exists, and "gh auth login" has been run.
cd /d "%~dp0"
if not exist .git (
  git init -b main
  git add -A
  git commit -m "Add Gyrai project website"
)
gh repo create gyrai/website --public --source . --push
if errorlevel 1 (echo Repository creation failed. Check that the gyrai organization exists and gh is logged in. & exit /b 1)
gh api -X POST repos/gyrai/website/pages -f "source[branch]=main" -f "source[path]=/"
gh api -X PUT repos/gyrai/website/pages -f cname=gyrai.org
echo.
echo Done. Next: add the DNS records at Hover, then turn on "Enforce HTTPS" in the repository's Pages settings.
pause
