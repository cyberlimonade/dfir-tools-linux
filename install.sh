workdir=$(pwd)

#installation des prérequis
sudo add-apt-repository universe

sudo apt-get update
sudo apt install curl qemu-utils wget gpg python3-dev vim htop bmon gcc build-essential linux-headers-$(uname -r) make dkms nmap net-tools hping3 arping foremost libimage-exiftool-perl sonic-visualiser wxhexeditor hexedit gparted rsync tcpdump wget curl tree minicom git whois nethogs testdisk openssh-server openssl sqlite3 python3-pip tshark openssl keepassx gufw rename parted p7zip wireshark

#installation de docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#installation de vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insider

python3 -m venv .venv
source .venv/bin/activate

if [ ! -d volatility3 ]
then
#installation de volotility
git clone https://github.com/volatilityfoundation/volatility3.git
cd volatility3
pip install -r requirements.txt
wget -O volatility3/symbols/windows.zip https://downloads.volatilityfoundation.org/volatility3/symbols/windows.zip
wget -O volatility3/symbols/linux.zip https://downloads.volatilityfoundation.org/volatility3/symbols/linux.zip
cd volatility3/symbols
unzip windows.zip
unzip linux.zip
rm *.zip
cd $workdir
fi

if [ ! -d DidierStevensSuite ]
then
#installation des outils de didierstevens
git clone https://github.com/DidierStevens/DidierStevensSuite.git
fi
#installation de evtx_dump pour parser les evtx
curl -s https://api.github.com/repos/omerbenamram/evtx/releases/latest | grep "browser_download_url" | grep "x86_64-unknown-linux-gnu" | cut -d : -f 2,3 | tr -d \" | wget -q -O evtx_dump -i - && chmod +x evtx_dump



#installation des librairies python nécessaires
pip install -r requirements.txt

sudo docker pull log2timeline/plaso
sudo docker pull splunk

