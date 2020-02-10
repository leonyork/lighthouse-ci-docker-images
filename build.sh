#!/usr/bin/env sh
#######################################################################
# Build, test and push the images
# Creates multiple versions so that there's some choice about versions
# to use
#######################################################################
set -eux

# Number of releases to go back from the latest version
number_of_lighthouse_ci_releases=3
number_of_cypress_releases=5

# Creates tags of the form {LIGHTHOUSECI_VERSION}-{CYPRESS} (e.g. 1.10.0-cypress13.3.0)
# First gets the last $number_of_cypress_releases tags where the tag looks like a version number
# For each of those tags gets the last $number_of_lighthouse_ci_releases of non-release candidate versions and builds an image
docker run leonyork/docker-tags cypress/included \
    | grep -E '^[0-9.]+$' \
    | tail -n $number_of_cypress_releases \
    | xargs -I{CYPRESS} -n1 \
        sh -c "docker run leonyork/npm-versions lighthouse-ci \
        | grep -E '^[0-9.]\.[0-9.]+$' \
        | tail -n $number_of_lighthouse_ci_releases \
        | xargs -I{LIGHTHOUSECI_VERSION} -n1 sh build-image.sh {CYPRESS} {LIGHTHOUSECI_VERSION} {LIGHTHOUSECI_VERSION}-cypress{CYPRESS} || exit 255" || exit 255

# Generates the latest tag
cypress_latest_version=`docker run leonyork/docker-tags cypress/included | grep -E '^[0-9.]+$' | tail -n 1`
lighthouse_ci_latest_version=`docker run leonyork/npm-versions lighthouse-ci | grep -E '^[0-9.]\.[0-9.]+$' | tail -n 1`
sh build-image.sh $cypress_latest_version $lighthouse_ci_latest_version latest