---
title: youtube-dl
---

## Sample commands
```
youtube-dl -o "%(playlist_index)s. %(title)s.%(ext)s" --playlist-start 20 https://www.youtube.com/playlist?list=PL8dPuuaLjXtNM_Y-bUAhblSAdWRnmBUcr

youtube-dl -o "Ottoman History Podcast Season 6/%(title)s.%(ext)s" https://soundcloud.com/ottoman-history-podcast/sets/ottoman-history-podcast-2

youtube-dl -o "%(playlist_index)s. %(title)s.%(ext)s" https://www.youtube.com/playlist?list=PL1328115D3D8A2566

youtube-dl --all-subs -o "Polish Witcher Audiobook Samples/%(playlist_index)s. %(title)s.%(ext)s" https://www.youtube.com/playlist?list=PLOF_3zZ1EK8hyvikkMeWHGu2BxA_LMGYW
```

## Usage
```bash
# default video settings
-f 'bestvideo[vcodec *= av01]+bestaudio/bestvideo[vcodec *= vp9]+bestaudio/bestvideo+bestaudio/best'

# Default settings
youtube-dl -o "$directory\%(title)s.%(ext)s" --ignore-errors VIDEO_URL

# List formats
youtube-dl -F $video

# Download a specific formats
youtube-dl -f $format_number $video_url

# specify video + audio format
youtube-dl -f 248+171 https://www.youtube.com/watch?v=???

# current setting
-f "bestvideo[width<=1920][ext=mp4]+bestaudio[ext=m4a]"

# 1080p
-f bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm]

# 60fps
-f "(mp4)[height=1080][fps=60]+bestaudio[ext=m4a]"

# 720p
-f "(mp4)[height=720]+bestaudio[ext=m4a]"

# Best audio
-f bestaudio[ext!=webm]/best[ext!=webm]

# Numbering
%(playlist_index)s

# Download from file
youtube-dl -a list

# ignore errors
-i

# Range
--playlist-start $num
--playlist-end $num

# Subtitles
--all-subs
```

## Config
```bash title="location"
# osx
~/.config/youtube-dl/config

# linux
/.config/youtube-dl/config
```

```bash title="settings"
-o "%(title)s.%(ext)s" --ignore-errors
# -f bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm]
#-f (bestvideo[ext!=webm]/bestvideo[ext!=av01])+bestaudio[ext!=webm]/$
#-f "(mp4)[height=1080][ext!=webm]+bestaudio[ext=m4a]"
#-f "(mp4)[width=1920][ext!=webm]+bestaudio[ext=m4a]"
#-f "(mp4)([width=1920]|[width=720])[ext!=webm]+bestaudio[ext=m4a]"
#-f "bestvideo[width<=1920][ext=mp4]+bestaudio[ext=m4a]"-f "(mp4)[wid$
-f "bestvideo[width<=1920][ext=mp4]+bestaudio[ext=m4a]"
```
