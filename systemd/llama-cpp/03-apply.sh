#!/bin/bash

# serve
sudo mkdir -p /opt/llama-cpp
sudo cp models.ini /opt/llama-cpp/
sudo cp llama-server.service /etc/systemd/system/

sudo systemctl restart llama-server
sudo systemctl status llama-server

# llama-server -m /opt/huggingface/models/unsloth/gemma-4-E2B-it-GGUF/gemma-4-E2B-it-Q4_K_M.gguf --port 8080
# llama-server --models-preset /opt/llama-cpp/models.ini --models-max 1 --host 0.0.0.0 --port 30050
