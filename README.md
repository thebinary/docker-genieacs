# docker-genieacs
__GenieACS - Docker build and compose files__

## Build Docker Image
Dockerfile has 2 args with default values that is used in building the image:

|ARG       | Remarks                        | Default                             |
|:---------|--------------------------------|-------------------------------------|
|REPO_URL  |GenieACS source git repo to use |https://github.com/genieacs/genieacs |
|BRANCH    |Git branch to use for the build | master                              |

### Examples

1. Build using [genieacs](https://github.com/genieacs/genieacs) master branch
```
docker build -t genieacs:latest .
```

2. Build using [genieacs](https://github.com/genieacs/genieacs) xmpp branch
```
docker build -t genieacs:xmpp --build-arg BRANCH=xmpp  .
```

3. Build using [forked thebinary/genieacs](https://github.com/thebinary/genieacs) xmpp branch
```
docker build -t thebinary/genieacs:xmpp --build-arg REPO_URL=https://github.com/thebinary/genieacs --build-arg BRANCH=xmpp .
```


## Run services in docker

The docker-compose uses variables for genieacs image tag to use to run:
|Variable          | Remarks                       |
|:-----------------|--------------------------------|
|GENIEACS_BRANCH   | used when build is required to specify which git branch to use for image build |
|GENIEACS_TAG      | docker image tag to use for running the service |

Since, these variables are required for docker-compose to work, you need to pass these vars either using .env file specifying a env file as docker-compose flag.
A env.sample file is provided for ease. You can use the provided env.sample as .env  
```
cp env.sample .env
```  

__Examples__

1. Run all genieacs services - cwmp, nbi and fs
```
docker-compose up -d
```

2. Run cwmp and nbi only
```
docker-compose -f docker-compose.cwmp.yml -f docker-compose.nbi.yml up -d
```

3. Run all genieacs services - cwmp, nbi and fs using a specific env file
```
docker-compose --env-file env.sample up -d
```
