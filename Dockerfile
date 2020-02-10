# Creates an image that can be used for building the client app. Since there are multiple variables (e.g. Cognito urls)
# that are needed for the build, we create a builder image rather than a traditional archive. These variables are passed
# in as environment variables when running the build
ARG CYPRESS_VERSION
FROM cypress/included:${CYPRESS_VERSION} AS base

ARG LIGHTHOUSECI_VERSION
RUN npm install -g lighthouse-ci@${LIGHTHOUSECI_VERSION}

ENTRYPOINT [ "lighthouse-ci" ]
CMD ["--help"]