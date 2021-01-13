# Stage: Build
FROM node:12-alpine as builder
LABEL stage=builder
LABEL maintainer="binary4bytes@gmail.com"

ARG REPO_URL=https://github.com/genieacs/genieacs
ARG BRANCH=master

WORKDIR /usr/src

RUN set -eux; \
  apk add --no-cache git; \
  git clone -b ${BRANCH} ${REPO_URL}; \
  cd genieacs; \
  npm install; \
  npm run build


# Stage: Final Image 
FROM node:12-alpine
LABEL maintainer "binary4bytes@gmail.com"

COPY --from=builder /usr/src/genieacs/dist /opt/genieacs 

WORKDIR /opt/genieacs

RUN set -eux; \
  # install \
  npm install --cache /tmp/npm-cache; \ 
  # cleanup \
  rm -rf /root/.node-gyp /tmp/npm-*; \
  # bin links \
  ln -s /opt/genieacs/bin/genie* /usr/bin

ENV GENIEACS_CWMP_PORT 7777
ENV GENIEACS_NBI_PORT 7777
ENV GENIEACS_FS_PORT 7777
ENV GENIEACS_UI_PORT 7777

EXPOSE 7777

# Nullify entrypoint of nodejs
ENTRYPOINT ["/usr/bin/env"]
CMD ["sh"]
