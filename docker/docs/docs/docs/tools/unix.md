---
title: Unix
---

## Archive
### tar
```bash
# create archive
tar -czvf ARCHIVE_NAME.tar.gz FILE_OR_FOLDER_PATH

# extract
tar -xzvf archive.tar.gz -C /tmp
```

### gzip
```bash
# create archive
gzip comp_listing.tsv # .gz extension will be automatically added

# loop
for i in */*.jl; do echo "$i" && gzip "$i"; done
```

### zip
```bash
# create archive
zip myfile.zip filename.txt

## multiple files
zip -r foo.zip .

# add file to zip archive
zip -g venv.zip lambda_function.py

# remove file from zip archive
zip -d gallery.zip "picture_43_9.jpg"

# zip individual files seprately
$ for i in *; do zip `basename $i .wmv`.zip $i; done
$ for i in *.csv; do zip `basename $i .csv`.zip $i; done

# zip each file in a folder separately
for i in *; do zip -r `basename $i`.cbz $i; done
```

## Bash
### Loop
```bash
### loop
for file in *.txt
do
  cat $file
done

### infinite loop
#!/bin/bash
while
  secs=$((5))
  while [ $secs -gt 0 ]; do
     echo -ne "$secs\033[0K\r"
     sleep 1
     : $((secs--))
  done
do
  python3 run.py
done
```

### If-Else
```bash
if [ $(whoami) = 'root' ]; then
	echo "You are root"
else
	echo "You are not root"
fi
```

### I/O
```bash
### split file
split -l 300 file.txt new
split -b 500m httpd.log

### change file encoding
iconv -f cp874 -t utf-8 FILEIN > FILEOUT

### fast delete
mkdir empty_dir
rsync -a --delete empty_dir/ .
perl -e 'for(<*>){((stat)[9]<(unlink))}'

### cat specific line
cat listing_raw_15.jl | sed '435!d'
```

### CRUD
```bash
### add extension to output name
for i in *; do mv "$i" "$i.csv"; done

### rename extension
for file in *.txt
do
  mv "$file" "${file%.txt}.json"
done

### concat *.gz together w/o header (og has header)
for i in *.gz; do zcat "$i" | sed -n '2,$p'; done > output.csv
## osx
for i in *.gz; do zcat < "$i" | sed -n '2,$p'; done > output.tsv

### replace string  in text file
sed  -i 's/old-text/new-text/g' input.txt
## osx
sed  -i .bak 's/old-text/new-text/g' input.txt

### replace \N with 0
sed -i "s/\\\N/0/g" ivs_subject.tsv

### recursive sed
find . -name "*.tsv" -type f | xargs sed -i .bak "s/\\\N/0/g"

# send grep output to mv
grep -l 'Subject: \[SPAM\]' | xargs -I '{}' mv '{}' DIR
```

### Misc
```bash
# kill all task containing a name
pkill -9

# loop range of numbers
for i in $(seq 5 $END); do echo $i; done

# list filename containing string
grep -rl delta_bed *.txt

# grep containing strings in file
grep -i delta_bed *.*

# create function (same as alias but also accept args)
youtube-dl-audio() {
    #do things with parameters like $1 such as
    #mv "$1" "$1.bak"
    #cp "$2" "$1"
    youtube-dl -f bestaudio[ext!=webm]/best[ext!=webm] -a "$1"
}
```

## Curl
```bash
### POST w payload from file
curl -X POST -d @get_price_condo_input.json http://example.com/path/to/resource

### GET  w formdata
curl --data "param1=value1&param2=value2" https://example.com/resource.cgi

### specify header
--header "Content-Type:application/json"
```

## Mount & Umount
`apt install ntfs-3g`

```bash
## https://gist.github.com/etes/aa76a6e9c80579872e5f
sudo blkid # find devices
mkdir /mnt/volume
sudo chmod 770 /mnt/volume # set permission for mount point
sudo mount /dev/sda1 /mnt/volume

# Auto mount at boot
sudo nano /etc/fstab
UUID=D424912B2491119A /mnt/media FILE_SYSTEM uid=1000,gid=1000,nofail,umask=0 0 0

# File Systems
ntfs-3g, vfat

# Mount NAS Share
sudo mount -t cifs //${IP}/Media/Music/Epica /mnt/dietpi_userdata/music -o username=ADMIN,password=PASSWORD,vers=1.0
```

### WebDAV
`apt install davfs2`

```bash
cd ~/ && mkdir app_data

# add in /etc/fstab
https://nextcloud.karnwong.me/remote.php/dav/files/$USERNAME/Apps/ /home/pi/app_data davfs _netdev,rw,user 0 0

# add in /etc/davfs2/secrets
/home/pi/app_data $USERNAME $PASSWORD
```

## rsync
```bash
rsync -avz --exclude=.DS_Store --progress ~/Git/ nextcloud:/home/macbook_git

rsync -Pav -e "ssh -i $HOME/.ssh/somekey" username@hostname:/from/dir/ /to/dir/

# copy with progress bar
rsync -ah --progress source-file destination-file

# move files
--remove-source-files
```

## SCP
```bash
# Transfer via SSH (Host to Remote)
scp -r wallabag pi@192.168.1.45:/home/pi
scp -i ~/.ssh/id_rsa.pub FILENAME USER@SERVER:/home/USER/FILENAME

# Transfer via SSH (Remote to Host)
scp [[user@]from-host:]source-file [[user@]to-host:][destination-file]

scp your_username@remotehost.edu:/some/remote/directory/\{a,b,c\} .
```

## SSH
### Create SSH key
```bash
ssh-keygen -b 2048 -t rsa
```

### SSH config
```ssh-config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa

Host github-COMPANY
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_COMPANY
```

### Disable password auth
```bash
$ sudo nano /etc/ssh/sshd_config

# change this line
PasswordAuthentication no

# restart
$ sudo /etc/init.d/ssh restart
```

### Port forwarding
```bash
ssh -L 5000:targethost:5000   NAME@TUNNEL_HOST
```

### OPENSSH setup
```bash
# install
$ sudo apt-get install openssh-server openssh-client
$ sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original_copy

# verify port
$ nc -v -z localhost 22
$ telnet localhost 9000
```

## wget
```bash
# download from file
wget -i links.txt
```

## System
```bash
# see killed processes
dmesg

# kill all processes
killall python3

# add path env
PATH=$PATH:~/opt/bin

PATH=~/opt/bin:$PATH

# check internet speed via terminal
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -

pip install --user speedtest-cli

sudo apt install speedtest-cli
speedtest-cli

# set maximum storage for logs
https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs

# disable network interface
sudo ifconfig wlan0 down
```

## tmux
```bash
# list sessions
tmux ls

# Rename
Ctrl + B, $

# Start new session
tmux new -s SESSION_NAME

# Exit
Ctrl+B then D

# Reattach
tmux attach -t session_name
tmux a

# scroll
Ctrl + B + [ --> then arrow keys # exit with q
```

## Recipes
### Save colored stdout to html
http://www.pixelbeat.org/scripts/ansi2html.sh

```
pdiffjson  -c listing_raw_schema.json listing_raw_new_schema.json | ./ansi2html.sh > filename.html
```
