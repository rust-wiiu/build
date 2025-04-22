# build
Utilities for building rust-wiiu software

## Build

`docker build -t <TAG> .`

## How to use

### Terminal

1. `docker run <TAG>`
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
