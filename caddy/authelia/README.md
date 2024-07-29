# Authelia

## Refs
- <https://blog.cyril.by/en/software/single-sign-on/installing-authelia-for-sso-all-in-one-guide>
- <https://docs.ibracorp.io/authelia/configuration-files/configuration.yml>

## Setup

```bash
curl https://apt.authelia.com/organization/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://apt.authelia.com/stable/debian/debian/ all main" | sudo tee /etc/apt/sources.list.d/authelia-stable-debian.list
sudo apt-get update
sudo apt install authelia -y

# access via <http://localhost:9091>
sops -d configuration.sops.yml > configuration.yml && sudo cp configuration.yml /etc/authelia/configuration.yml
sops -d users_db.sops.yml > users_db.yml && sudo cp users_db.yml /etc/authelia/users_db.yml

sudo systemctl restart authelia
```
