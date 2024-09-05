#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No argument supplied.}"
    echo "Usage: extractpbo.sh <LINK_TO_PBO_FILE>"
    exit 1
elif [ ! -f $(readlink -f $1) ]; then
    echo "Error: File not found."
    echo "Usage: extractpbo.sh <LINK_TO_PBO_FILE>"
    exit 1
fi

file_link=$(readlink -f $1)
file_name=$(echo $file_link | rev | cut -d "/" -f 1 | rev)

if [[ $(echo $file_name | rev | cut -d "." -f 1 | rev) != "pbo" ]]; then
    echo "Error: The file is not a PBO file."
    echo "Usage: extractpbo.sh <LINK_TO_PBO_FILE>"
    exit 1
fi

container_id=$(docker run --rm -d --workdir /app depbo:latest sleep infinity)

docker cp $file_link $container_id:/app/work.pbo

docker exec -it $container_id extractpbo work.pbo

result_name=$(echo $file_name | rev | cut -d "." -f 2- | rev)
result_link=$(echo $file_link | rev | cut -d "/" -f 2- | rev)
result_link=$(readlink -f "${result_link}/${result_name}")

docker cp $container_id:/app/work $result_link

nothing=$(docker rm -f $container_id)

echo "Success of PBO extraction into folder '${result_link}'"
