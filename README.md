# Building Rust Wii U Software: Utility Tools

This repository provides a Docker image to quickly and easily build Rust Wii U software. It contains all the necessary dependencies and tools to get started with development. Additionally it helps with support requests by providing a uniform platform to avoid the common "It does(n't) work on *my* machine".

## Obtain the Docker Image

**Step 1: Log in to GitHub Container Registry**

To access the image, you need to authenticate with GitHub. Use your GitHub username and a [personal access token](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#about-the-container-registry) that has at least `read:package` permissions. Run the following command in your terminal and enter your credentials when prompted:

```shell
docker login ghcr.io
```

**Step 2: Pull the Docker Image**

Next, download the specific version of the build image you need. Replace `<TAG>` with the desired tag (e.g., `main`, `v1.2.3`).

```shell
docker pull ghcr.io/rust-wiiu/build:<TAG>
```

**Step 3: Verify Image Download**

Confirm that the image has been successfully downloaded by listing your local Docker images:

```shell
docker images
```

You should see `ghcr.io/rust-wiiu/build` in the list.

## Using the Build Environment

### Running the Image

You can interact with the build environment by running the Docker image in interactive mode. This command starts a new container from the image and gives you a shell prompt inside it:

```shell
docker run -it --name <NAME> ghcr.io/rust-wiiu/build
```

Replace `<NAME>` with a name you choose for your container (e.g., `rust-wiiu`). You can exit this shell session at any time by typing `exit` or pressing `Ctrl+D`.

### Managing Existing Containers

If you've exited a container, you can start it again and re-attach to its shell:

  * **Start a stopped container:**

    ```shell
    docker start <NAME>
    ```

  * **Connect to a running container:**

    ```shell
    docker attach <NAME>
    ```

## Accessing Files

To move local files in or retrieve the compiled binaries from the Docker container, you can [mount](https://docs.docker.com/engine/storage/bind-mounts/) a local folder on your computer to a directory inside the container. This allows you to access the files directly from your host system. You would typically do this when running the `docker run` command using the `-v` flag (for volume mounting). `<LOCAL>` is the **absolute path** to the folder on the host system and `<REMOTE>` is the **absolute path** inside the container where you want to mount it. The recommended remote path is `/home/dev/...` (home directory).

```shell
docker run -it --name <NAME> -v "<LOCAL>:<REMOTE>" ghcr.io/rust-wiiu/build
```

### Example

You can use these system-specific variables to represent your current host path
- `$(pwd)`: For Unix-style terminals (Linux or macOS)
- `$PWD` or `${PWD}`: For PowerShell (Windows)
- `%cd%`: For Command Prompt (Windows)

This example mounts the current working directory onto the folder `~/my-project`.

```shell
docker run -it --name wiiu -v "${PWD}/:/home/dev/my-project" ghcr.io/rust-wiiu/build:main
```

## Available Utilities

### `clone`

The `clone` command simplifies the process of downloading multiple repositories at once. Simply provide a comma-separated list of repository names (without the `rust-wiiu/` prefix).

**Example:**

To clone and build the `rust-wiiu/wwhd-trainer` project you can run:

```shell
clone wut, wups, notifications, overlay, wwhd-trainer
cd wwhd-trainer
cargo make --profile release build
```

## Building the Docker Image Locally

If you need to build the Docker image yourself (e.g., for development purposes or customization), you can do so using the provided `Dockerfile`.

```shell
docker build -t <TAG> .
```

Replace `<TAG>` with a tag you want to give your locally built image (e.g., `<USERNAME>/rust-wiiu`). The `.` at the end specifies the current directory as the build context (where the `Dockerfile` is located).
