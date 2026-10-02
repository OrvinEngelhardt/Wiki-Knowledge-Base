#!/usr/bin/env bash
sudo apt-get install -y docker docker-compose-plugin

cd "$(dirname "$0")"
sudo docker compose up -d
