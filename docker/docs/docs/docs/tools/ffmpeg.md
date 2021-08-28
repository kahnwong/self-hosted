---
title: FFMPEG
---

```bash title="convert to H.264"
ffmpeg\
    -i "Screen Recording 2020-04-17 at 5.23.34 PM.mov"\
    -vcodec libx264\
    -crf 23\
    -preset fast\
    -profile:v baseline\
    -level 3\
    -refs 6\
    -vf "scale=1920:-1,format=yuv420p"\
    -acodec copy output.mp4
```

```bash title="standard preset"
ffmpeg -i $FILENAME -c:v libx264 -preset slow -crf 22 -c:a copy output.mkv
```

```bash title="resample bitrate"
ffmpeg -i input.mp4 -b:v 1M -b:a 192k output.avi
```

```bash title="extract audio"
ffmpeg -i IN_FILE  -vn -acodec copy OUT_FILE
```
