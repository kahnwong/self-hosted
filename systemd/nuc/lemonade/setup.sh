#!/bin/bash

sudo add-apt-repository ppa:lemonade-team/stable
sudo apt install -y lemonade-server lemonade-desktop

lemonade backends install llamacpp:vulkan
lemonade pull Bonsai-1.7B-gguf

# web app: http://localhost:13305
