# Depbo tools for linux

Tool to pack and unpack folder in Arma 3 PBO file

## Build in docker image

```bash
docker build -t depbo:latest .
```

## Usage with docker

```bash
# To make pbo file
./makepbo.sh <LINK_TO_FOLDER>

# To extract pbo file
./extractpbo.sh <LINK_TO_PBO_FILE>
```

## Copyright

Original tool "depbo-tools" create by [Mikero](https://community.bistudio.com/wiki/Mikero_Tools)

Link to original [Topic](https://securitronlinux.com/bejiitaswrath/how-to-extract-an-arma-3-pbo-file-on-linux-using-pbo-tools/)
