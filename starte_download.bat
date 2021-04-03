@echo off

REM Workaround: bei mir klappt das konvertieren mit youtube-dl nicht 
REM         unter Windows. Daher:

REM Ein Script, dass youtube-dl nutzt, um Videos herunter zu laden
REM         und in mp3 zu konvertieren.
REM Die Links, die runtergeladen werden, müssen in der 
REM         Datei "linkliste.txt" eingetragen sein. 
REM Für die Konvertierung wird ffmpeg verwendet. 
REM         ffmpeg einfach hier runterladen: https://ffmpeg.org/
REM         und in venv\Scripts\ ablegen.



REM virtuelle Umgebung starten
call venv\Scripts\activate.bat
if not %ERRORLEVEL%==0 (
    echo.
    echo !! kann venv\Scripts\activate.bat nicht aufrufen !!
    echo.
    echo erzeugen der virtuellen Umgebung:
    echo =====================================================================
    echo python -m venv venv             REM virt. Umgebung erstellen
    echo venv\Scripts\activate.bat       REM vitr. Umgebung oeffnen
    echo pip install youtube-dl          REM youtube-dl herunterladen + inst.
    echo =====================================================================
    echo.
    echo es wird abgebrochen
    echo.
    echo.
    goto ENDE
)

call ffmpeg -version
if not %ERRORLEVEL%==0 (
    echo ffmpeg kann nicht gefunden werden
    echo ffmpeg wird zur Konvertierung der Filme nach mp3 benoetigt
    echo der Download wird durchgefuehrt, die Konvertierung wird uebersprungen
    set ffmpeg=0
    pause
)

echo ===================================================================
echo                             starte download
echo ===================================================================
REM runterladen
call youtube-dl -a linkliste.txt

REM nach mp3 convertieren
echo ===================================================================
echo                   starte convertierung nach mp3
echo ===================================================================
if ffmpeg==0 goto EOF
dir /B /A-D > videofiles.txt

for /F "usebackq tokens=*" %%A in ("videofiles.txt") do (
    set "VIDEO="
    if %%A==%~n0%~x0 set VIDEO=0
    if "%%A"=="linkliste.txt" set VIDEO=0
    if "%%A"=="videofiles.txt" set VIDEO=0
    if "%%A"=="readme.txt" set VIDEO=0
    
    if not defined VIDEO (
        ffmpeg -i "%%A" "%%~nA.mp3"
    )
)

del videofiles.txt

echo ===================================================================
echo                              fertig
echo ===================================================================

:ENDE
pause
