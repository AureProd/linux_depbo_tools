# linux_depbo_tools

Juste a git for simple import of depbo-tools to linux

## How to deploy 

### Install libraries

- For Debian/Ubuntu, run this : ```apt-get install liblzo2-2 libvorbis0a libvorbisfile3 libvorbisenc2 libogg0```
- For RHEL/CentOS, run this : ```yum install lzo libvorbis libogg```

### Install executables

- Copy all elements of [bin](https://github.com/HuetJB/linux_makepbo/tree/main/depbo-tools-0.6.24/bin) to ```/bin``` of your linux server.
- Copy all element of [lib](https://github.com/HuetJB/linux_makepbo/tree/main/depbo-tools-0.6.24/lib) to ```/usr/local/lib/``` of your linux server.

### Finish installation 

- Run this commande : ```sudo ldconfig```

## Utilisation

- For create pbo : ```makepbo -N <LINK_TO_MISSION_DIRECTORY> <LINK_TO_GENERATION_DIRECTORY>```
- For extract pbo : ```extractpbo <LINK_TO_MISSION_PBO_FILE>```

## Copyright

L'outil initial "depbo-tools" à été crée par [Mikero](https://community.bistudio.com/wiki/Mikero_Tools)
