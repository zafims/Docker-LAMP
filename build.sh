#!/usr/bin/env bash
cd "$(dirname "$(readlink -f "$0" || realpath "$0")")"

docker-compose up -d --build

#read -p "Press any key to resume ..."
