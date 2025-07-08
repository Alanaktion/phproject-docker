#!/bin/bash
# Build a release image for phproject

set -e

if [ -n "$1" ]; then
    version="$1"
else
    version="master"
fi

rm -rf src
git clone https://github.com/Alanaktion/phproject.git --branch "$version" --single-branch --depth 1 src

pushd src
docker run --rm \
    --volume $PWD:/app \
    --user $(id -u):$(id -g) \
    composer install --no-ansi --no-interaction --no-dev
rm -rf .git* .vscode
rm -f composer.phar
popd

docker buildx ls || docker buildx create --use

platform="linux/amd64,linux/arm/v7,linux/arm64"
image="alanaktion/phproject"
if [ $version = "master" ]; then
    docker buildx build \
        --platform "$platform" \
        --tag "docker.io/$image:apache-master" \
        --tag "ghcr.io/$image:apache-master" \
        --push .
else
    docker buildx build \
        --platform "$platform" \
        --tag "docker.io/$image:apache-${version:1}" \
        --tag "docker.io/$image:apache" \
        --tag "ghcr.io/$image:apache-${version:1}" \
        --tag "ghcr.io/$image:apache" \
        --push .
fi
