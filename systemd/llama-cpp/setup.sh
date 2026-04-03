#!/bin/bash

# install llama.cpp
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install llama.cpp

# install hugging face downloader
curl --silent --location \
  https://raw.githubusercontent.com/houseabsolute/ubi/master/bootstrap/bootstrap-ubi.sh |
  sudo sh
sudo ubi --project bodaay/HuggingFaceModelDownloader --in /usr/local/bin/ --rename-exe hfdownloader

# create model dirs
sudo mkdir -p /opt/models

# download
sudo hfdownloader download ggml-org/gemma-3-1b-it-GGUF:q4_k_m --cache-dir /opt/models
sudo hfdownloader download unsloth/gemma-4-E2B-it-GGUF:q4_k_m --cache-dir /opt/models

# serve
sudo mkdir -p /opt/llama-cpp
sudo cp models.ini /opt/llama-cpp/

# llama-server -m /opt/models/models/unsloth/gemma-4-E2B-it-GGUF/gemma-4-E2B-it-Q4_K_M.gguf --port 8080
# llama-server --models-preset /opt/llama-cpp/models.ini --models-max 1 --host 0.0.0.0 --port 30050
