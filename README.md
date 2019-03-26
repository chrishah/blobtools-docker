# blobtools-docker
Ubuntu 18.04 with blobtools

The image contains a full install of [blobtools](https://github.com/DRL/blobtools), including all necessary dependencies. I am not part of the developer team - I just made this image.

In detail, the image is set up with:
 - Ubuntu 18.04
 - samtools v1.9.0
 - blobtools v1.1.1
 - nodeDB built with blobtools (from taxonomy dump 26.03.2019)

To run [blobtools](https://github.com/DRL/blobtools) you can do the following (this will mount the directory `/in` of the container to the current working directory on your local machine, and allow you to access files in this directory and any sub-directories):
```bash
$ docker run --rm -v $(pwd):/home/in -w /in chrishah/blobtools:v1.1.1 blobtools
```

You can also enter the container environment and work within it. All executables should be in the `PATH`.
```bash
$ docker run -it --rm -v $(pwd):/in -w /in chrishah/blobtools:v1.1.1 /bin/bash
```

Do a plot with example data provided with the package:
```
docker run --rm -v $(pwd):/in/ -w /in/ chrishah/blobtools:v1.1.1 \
blobtools create \
-i /usr/src/blobtools-blobtools_v1.1.1/example/assembly.fna \
-b /usr/src/blobtools-blobtools_v1.1.1/example/mapping_1.sorted.bam \
-t /usr/src/blobtools-blobtools_v1.1.1/example/blast.out \
-o test

docker run --rm -v $(pwd):/in/ -w /in/ chrishah/blobtools:v1.1.1 \
blobtools view -i test.blobDB.json

docker run --rm -v $(pwd):/in/ -w /in/ chrishah/blobtools:v1.1.1 \
blobtools plot -i test.blobDB.json
```

