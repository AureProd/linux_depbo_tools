# linux_makepbo

Juste a git for simple import of makepbo to linux

## How to deploy 

### Install libraries

- For Debian/Ubuntu, run this : ```sudo apt-get install liblzo2-2 libvorbis0a libvorbisfile3 libvorbisenc2 libogg0```
- For RHEL/CentOS, run this : ```sudo yum install lzo libvorbis libogg```

### Install executables

- Copy all elements of [~/bin](https://github.com/HuetJB/linux_makepbo/tree/main/bin) to ```/bin``` of your linux server.

### Finish installation 

- Run this commande : ```sudo ldconfig```

## Utilisation

- For create pbo : ```makepbo```
- For extract pbo : ```extractpbo```
