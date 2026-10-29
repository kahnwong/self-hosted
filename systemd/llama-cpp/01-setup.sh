#!/bin/bash

# install llama.cpp
curl -LsSf https://llama.app/install.sh | sh

# install hugging face downloader
curl --silent --location \
	https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh |
	sudo sh
sudo ubi --project bodaay/HuggingFaceModelDownloader --in /usr/local/bin/ --rename-exe hfdownloader
