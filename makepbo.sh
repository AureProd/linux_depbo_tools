#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No argument supplied."
    echo "Usage: makepbo.sh <LINK_TO_FOLDER>"
    exit 1
elif [ ! -d $(readlink -f $1) ]; then
    echo "Error: Directory not found."
    echo "Usage: makepbo.sh <LINK_TO_FOLDER>"
    exit 1
fi

directory_link=$(readlink -f $1)
directory_name=$(echo $directory_link | rev | cut -d "/" -f 1 | rev)

container_id=$(docker run --rm -d --workdir /app depbo:latest sleep infinity)

docker cp $directory_link $container_id:/app/work

docker exec -it $container_id makepbo -N work

result_link=$(readlink -f "${directory_link}/../${directory_name}.pbo")

docker cp $container_id:/app/work.pbo $result_link

nothing=$(docker rm -f $container_id)

echo "Success of PBO making into PBO file '${result_link}'"

