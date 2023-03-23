#!/bin/bash
# Build a release image for phproject

if [ -n "$1" ]; then
    version="$1"
else
    version="master"
fi

rm -rf src
git clone https://github.com/Alanaktion/phproject.git --branch "$version" --single-branch --depth 1 src

pushd src

if [ -z $(which composer) ]; then
    curl -o composer.phar -L https://getcomposer.org/composer-stable.phar
    $composer = "php composer.phar"
else
    $composer = "composer"
fi
$composer install --no-ansi --no-interaction --no-dev

rm -rf .git* .vscode
rm -f composer.phar

popd

docker buildx create --use
docker buildx ls

platform="linux/amd64,linux/arm/v7,linux/arm64"
image="alanaktion/phproject"
if [ $version = "master" ]; then
    docker buildx build \
        --platform "$platform" \
        --tag "$image:apache-master" --push .
else
    docker buildx build \
        --platform "$platform" \
        --tag "$image:apache-${version:1}" --tag "$image:apache" --push .
fi
