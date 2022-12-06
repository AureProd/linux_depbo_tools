#!/bin/bash

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
RESET="\e[0m"

if [ -z "$1" ]; then
    echo -e "${RED}Error: No argument supplied.${RESET}"
    echo -e "${RED}Usage: extractpbo.sh <LINK_TO_MISSION_PBO_FILE>${RESET}"
    exit 1
elif [ ! -f $(readlink -f $1) ]; then
    echo -e "${RED}Error: File not found.${RESET}"
    echo -e "${RED}Usage: extractpbo.sh <LINK_TO_MISSION_PBO_FILE>${RESET}"
    exit 1
fi

file_link=$(readlink -f $1)
file_name=$(echo $file_link | rev | cut -d "/" -f 1 | rev)

if [[ $(echo $file_name | rev | cut -d "." -f 1 | rev) != "pbo" ]]; then
    echo -e "${RED}Error: The file is not a PBO file.${RESET}"
    echo -e "${RED}Usage: extractpbo.sh <LINK_TO_MISSION_PBO_FILE>${RESET}"
    exit 1
fi

echo -e "${YELLOW}Extraction du pbo pour le fichier '${file_link}'${RESET}"

docker build -t depbo:latest 

container_id=$(docker run --rm -d --workdir /app depbo:latest sleep infinity)

echo -e "${YELLOW}Démarrage du container pour extraire le pbo (id: ${container_id})${RESET}"

docker cp $file_link $container_id:/app/work.pbo

docker exec -it $container_id extractpbo work.pbo

result_name=$(echo $file_name | rev | cut -d "." -f 2- | rev)
result_link=$(echo $file_link | rev | cut -d "/" -f 2- | rev)
result_link=$(readlink -f "${result_link}/${result_name}")

docker cp $container_id:/app/work $result_link

nothing=$(docker rm -f $container_id)

echo -e "${GREEN}Pbo extrait avec succes ici: '${result_link}'${RESET}"

