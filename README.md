![Trebuchet, powerful siege engine](.siege.png)

# Siege Docker Image
![action badge](https://github.com/stone/siege-docker/actions/workflows/docker-build.yml/badge.svg)
![Docker Image Version](https://img.shields.io/docker/v/ttyse/siege)
![Docker Pulls](https://img.shields.io/docker/pulls/ttyse/siege)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ttyse/siege/latest)



This repository provides a Dockerfile to build a containerized version of
[Siege](https://www.joedog.org/siege-manual/), a powerful HTTP load testing and
benchmarking tool.

Built upon a debian slim image, autobuilt and pushed once a week.

## Table of Contents

- [Getting Started](#getting-started)
- [Build the Image Locally](#build-the-image-locally)
- [Specify a Siege Version](#specify-a-siege-version)
- [Using the Docker Image](#using-the-docker-image)
- [Refer to Siege Documentation](#refer-to-siege-documentation)

---

## Getting Started

To use this Docker image, ensure you have Docker installed on your system. The
image can be used directly from a container registry (e.g., DockerHub) or built
locally using the provided Dockerfile.

## Build the Image Locally

If you want to build the Docker image locally, clone this repository and use the
following steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/stone/siege-docker.git
   cd siege-docker
   ```

2. Build the image using Docker:

   ```bash
   docker build -t siege:latest .
   ```

3. (Optional) Specify a Siege version during the build:

   ```bash
   docker build --build-arg SIEGE_VERSION=<desired_version> -t siege:<desired_version> .
   ```

   Replace `<desired_version>` with the specific version of Siege you want to use (e.g., `4.1.7`).

   You find releases here: https://download.joedog.org/siege/

## Specify a Siege Version

By default, the image is built with the version specified in the Dockerfile. To
use a specific version:

1. During build, pass the desired version using the `--build-arg` option:

   ```bash
   docker build --build-arg SIEGE_VERSION=4.1.7 -t siege:4.1.7 .
   ```

2. If pulling from a dockerhub remote registry, check the available tags to see specific versions.

## Using the Docker Image

Run the Siege container using the following command:

```bash
docker run --rm ttyse/siege:latest --help
```

To test a URL, pass it as an argument to the container:

```bash
docker run --rm ttyse/siege:latest https://example.com
```

You can also bind local configuration files or volumes if needed:

```bash
docker run --rm -v $(pwd)/config:/root/.siege ttyse/siege:latest https://example.url
```

For more advanced usage and options, refer to the [Siege Manual](https://www.joedog.org/siege-manual/).

## Refer to Siege Documentation

For detailed information on how to configure and use Siege, refer to its
official documentation:
[https://www.joedog.org/siege-manual/](https://www.joedog.org/siege-manual/).
