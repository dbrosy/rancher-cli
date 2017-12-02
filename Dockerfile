FROM alpine:3.7

LABEL maintainer="dbrosy@gmail.com"

# Define rancher version
ENV RANCHER_CLI_VERSION=v0.6.5 \
	RANCHER_COMPOSE_VERSION=v0.12.5 \
	YAML_VERSION=1.6 \
	RANCHER_URL= \
	RANCHER_ACCESS_KEY= \
	RANCHER_SECRET_KEY= \
	RANCHER_ENVIRONMENT=

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Install dependencies and rancher
RUN apk update && \
	apk upgrade && \
	apk add --no-cache ca-certificates && \
	apk add openssh-client && \
	apk add iputils && \
	apk add iproute2 && \
	apk add curl && \
	apk add bash && \
	apk add --quiet --no-cache --virtual build-dependencies curl && \
	curl -sSL "https://github.com/rancher/cli/releases/download/${RANCHER_CLI_VERSION}/rancher-linux-amd64-${RANCHER_CLI_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ --strip-components=2 && \
	curl -sSL "https://github.com/rancher/rancher-compose/releases/download/${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ --strip-components=2 && \
	chmod +x /usr/local/bin/rancher && \
	apk del build-dependencies && \
	rm -rf /var/cache/apk/*

RUN adduser -S docker-user
USER docker-user

ENTRYPOINT ["/docker-entrypoint.sh"]
