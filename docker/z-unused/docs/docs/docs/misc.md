---
title: Misc
---

## Calibre
### Plugboards

```t title="default"
{author}/{title}/{title} - {authors}
```

```
{authors}{series_index:>3s| — #| of }{series:| the | series }
{author}/{series} #{series_index} - {title}/{title} - {authors}
```

#### Save to disk template
```
{author}/{series} #{series_index} - {title}/{title} - {authors}
```
#### To kindle via KOReader
```
{authors} - {title}
```

## Fixes
### Android bluetooth keyboard pairing

https://www.reddit.com/r/GooglePixelC/comments/5resoy/keyboard_no_longer_pairing/dk5dr4v/

It sounds dumb and fake, but if you connect the tablet to the keyboard and then hold `Left Shift + P + A + I + R` at the same time for 2 seconds it fixes the issue and allows you to pair the keyboard! I found the fix posted on Reddit so make sure to thank the user.

### Bluetooth audio delay
`150ms` delay

### Windows network share
In Windows 10. Go to credential manager (click start and type "credential manager" or find it in control panel), click windows credentials and in windows credentials add your server share address with username and password. If you cannot see the share, just type your server and share address in the windows address field: `\server name\share name` or `\192.198.x.x\share name`.

### LINE Ads DNS
```
0.0.0.0 a.line.me
0.0.0.0 a.line.me.akadns.net
0.0.0.0 gwz.line.naver.jp
0.0.0.0 lan.line.me
0.0.0.0 lan.line.me.akadns.net
0.0.0.0 legy-gslb.line-apps.com.akadns.net
0.0.0.0 legy-gslb.line.naver.jp
0.0.0.0 nelo2-col.linecorp.com
```

### vscode SSH connection timeout
add this in settings:
```json
"remote.SSH.useLocalServer": false
```

## Mp3Tag
```
# output path
%albumartist% - %album%\%discnumber%\$num(%track%,2). %title%

# with year
%albumartist% - %album% (%year%)\%discnumber%\$num(%track%,2). %title%
```

## foobar
```
# sort
%album artist% - %DATE% - %ALBUM% - %DISCNUMBER% - %TRACKNUMBER% - %TITLE%

# Auto Playlist
%path% HAS \Films & TV (Asian) SORT BY album artist

%path% HAS \Motion Pictures\the hobbit   SORT BY   %DATE% - %ALBUM% - %DISCNUMBER%  AND %path% HAS  \Motion Pictures\the lord of the rings SORT BY   %DATE% - %ALBUM% - %DISCNUMBER%

# Sort by Year
%album artist% - $sub(9999,$year(%date%)) - %album% - %discnumber% - %tracknumber% - %title%
```

## Chocolatey
### Install
PowerShell only

```
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
```

### Usage
```bash
$ choco uninstall $app
$ clist -lo
$ cinst -y [package names]
$ choco search [package name]
```

```bash title="recipe"
cinst -y 7zip.install ccleaner cdburnerxp defraggler ditto f.lux fastcopy filezilla flac focuswriter foxitreader freefilesync fsviewer geany googlechrome googledrive handbrake itunes mkvtoolnix mp3tag nexusfile notepadplusplus.install recuva sharex steam sumatrapdf vlc windirstat winrar crystaldiskinfo
```
