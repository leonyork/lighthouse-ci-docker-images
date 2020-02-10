# Lighthouse-ci Docker images

Images for running [Lighthouse-ci](https://www.npmjs.com/package/lighthouse-ci).

## Build

```docker build --build-arg CYPRESS_VERSION=4.0.1 --build-arg LIGHTHOUSECI_VERSION=1.10.0 -t leonyork/lighthouse-ci .```

## Test

```docker run leonyork/lighthouse-ci --version```