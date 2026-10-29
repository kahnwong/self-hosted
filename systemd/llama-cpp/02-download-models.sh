#!/bin/bash

# create model dirs
sudo mkdir -p /opt/huggingface

# download
sudo hfdownloader download prism-ml/Bonsai-1.7B-gguf:Q1_0 --cache-dir /opt/huggingface
sudo hfdownloader download prism-ml/Bonsai-8B-gguf:Q1_0 --cache-dir /opt/huggingface
sudo hfdownloader download unsloth/gemma-4-E2B-it-GGUF:q4_k_m --cache-dir /opt/huggingface
sudo hfdownloader download LiquidAI/LFM3-1.7B-GGUF:q4_k_m --cache-dir /opt/huggingface

sudo hfdownloader download unsloth/Qwen3-VL-4B-Instruct-GGUF:q4_k_m --cache-dir /opt/huggingface
sudo wget -P /opt/huggingface/models/unsloth/Qwen3-VL-4B-Instruct-GGUF https://huggingface.co/unsloth/Qwen3-VL-4B-Instruct-GGUF/resolve/main/mmproj-BF16.gguf
