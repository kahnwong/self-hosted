# PyRSS

```bash
# transfer pyrss to /home/pi
cd ~/pyrss
cd ~/pyrss/PyRSS2Gen-1.1
sudo python3 setup.py install

echo 'PATH=/usr/bin:/bin
cd "/home/pi/pyrss"
python3 matichon_rss.py
# python3 pantip_rss.py
python3 baania_rss.py
sudo mv *.xml /var/www/wallabag/web' | sudo tee -a ~/scripts/rss.sh
sudo chmod +x ~/scripts/rss.sh
```

### atom1 to rss2
```bash
cd ~/scripts
git clone https://github.com/flrt/atom_to_rss2.git

pip3 install lxml arrow

echo 'cd ~/scripts

curl "https://reader.karnwong.me/public.php?op=rss&id=-2&key=uot5yz5d2d7a60b17c5" -o atom_feed.xml

python3 ~/scripts/atom_to_rss2/atom1_to_rss2.py --atom atom_feed.xml --rss2 podcasts.rss2' | tee -a ~/scripts/atom_to_rss2.sh

chmod +x atom_to_rss2.sh
```
