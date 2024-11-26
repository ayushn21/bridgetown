sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev \
 autoconf bison build-essential libyaml-dev libreadline-dev \
 libncurses5-dev libffi-dev libgdbm-dev jq -y

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https \
  libnspr4 libnss3 libnss3-tools
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

mkdir ~/tmp
cd ~/tmp
apt download caddy
mkdir -p caddy-unpack
dpkg -x $(find caddy*.deb) ~/tmp/caddy-unpack
sudo mv ~/tmp/caddy-unpack/usr/bin/caddy /usr/local/bin/caddy
cd ~/
rm -rf ~/tmp

sudo vim /etc/systemd/system/caddy.service
sudo systemctl daemon-reload
sudo systemctl enable --now caddy
systemctl status caddy

sudo su deploy

# Deploy
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc

rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv versions | tail -1)

nvm install node
nvm install-latest-npm
npm install yarn
