#!/bin/bash

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
RESET="\e[0m"

if [ -z "$1" ]; then
    echo -e "${RED}Error: No argument supplied.${RESET}"
    echo -e "${RED}Usage: makepbo.sh <LINK_TO_MISSION_DIRECTORY>${RESET}"
    exit 1
elif [ ! -d $(readlink -f $1) ]; then
    echo -e "${RED}Error: Directory not found.${RESET}"
    echo -e "${RED}Usage: makepbo.sh <LINK_TO_MISSION_DIRECTORY>${RESET}"
    exit 1
fi

directory_link=$(readlink -f $1)
directory_name=$(echo $directory_link | rev | cut -d "/" -f 1 | rev)

echo -e "${YELLOW}Création du pbo pour le dossier '${directory_link}'${RESET}"

docker build -t depbo:latest 

container_id=$(docker run --rm -d --workdir /app depbo:latest sleep infinity)

echo -e "${YELLOW}Démarrage du container pour créer le pbo (id: ${container_id})${RESET}"

docker cp $directory_link $container_id:/app/work

docker exec -it $container_id makepbo -N work

result_link=$(readlink -f "${directory_link}/../${directory_name}.pbo")

docker cp $container_id:/app/work.pbo $result_link

nothing=$(docker rm -f $container_id)

echo -e "${GREEN}Pbo créé avec succes ici: '${result_link}'${RESET}"

