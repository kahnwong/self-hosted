PATH=/usr/bin:/bin
cd "/home/pi/self-hosted/pyrss"

# python3 pantip_rss.py
# python3 matichon_rss.py
python3 baania_rss.py
python3 thestandard_rss.py

sudo mv *.xml /var/www/rss