# Youtube-dl workaround for (my) windows (problem)
On my windows youtube-dl does not work. So here is a little script to download all Youtube-Videos listed in the file `linkliste.txt` and convert them afterwards to mp3.

## Requirements

* Python 3+
* virtual Environment (venv) with installed youtube-dl
* ffmpeg

## Installation

create virtual environment
```
python -m venv venv
```
activate the virtual environment
```
venv\Scripts\activate
```
install youtube-dl
```
pip install youtube-dl
```

download ffmpeg.exe from <https://ffmpeg.org> and extract it to 
```
venv\Scripts\ffmpeg.exe
```
## usage / run
copy the URL's of the videos in the file `linkliste.txt` and run
```
starte_download.bat
```
