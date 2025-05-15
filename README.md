# build
Utilities for building rust-wiiu software

## How to use

### Pull image

1. Login with your Github username and [personal access token](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#about-the-container-registry) with at least `read:package` privileges
```
docker login ghcr.io
```

2. Pull the image
```
docker pull ghcr.io/rust-wiiu/build:<TAG>
```

3. Confirm image was downloaded and is available
```
docker images
```

### Terminal

1. `docker run <TAG> -v <LOCAL_DIR>:/home/rust-wiiu/<ENV_DIR>`
2. `docker exec -it <ID> sh`

### Docker Desktop

1. Images \> Run
2. Containers \> <CONTAINER> \> Exec

There is a shortcut for cloning `rust-wiiu` repos with `clone`. E.g. `clone wut, wups` will clone `rust-wiiu/wut` & `rust-wiiu/wups`

Example:

```
clone wut, wups, notifications, overlay, wwhd-trainer
cd wwhd-trainer
cargo make --profile release build
```

You can get the binaries by mounting a folder in the container to your filesystem.

## Build

`docker build -t <TAG> .`
