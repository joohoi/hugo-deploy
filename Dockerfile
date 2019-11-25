FROM alpine:latest
LABEL maintainer="Joona Hoikkala <joohoi@io.fi>"

LABEL "com.github.actions.name"="Hugo Deploy to repository"
LABEL "com.github.actions.description"="Build, commit and push Hugo site from a source repository to the deployment repository"
LABEL "com.github.actions.icon"="arrow-up-circle"
LABEL "com.github.actions.color"="blue"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	git

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
