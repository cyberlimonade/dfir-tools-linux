git clone https://github.com/volatilityfoundation/volatility3.git
git clone https://github.com/DidierStevens/DidierStevensSuite.git
#download evtx tool to parse evtx as XML files
curl -s https://api.github.com/repos/omerbenamram/evtx/releases/latest | grep "browser_download_url" | grep "x86_64-unknown-linux-gnu" | cut -d : -f 2,3 | tr -d \" | wget -q -O evtx_dump -i - && chmod +x evtx_dump
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt