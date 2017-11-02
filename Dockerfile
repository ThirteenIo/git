FROM alpine AS compile-image

LABEL maintainer Christophe Deliens <chris@deliens.be>

WORKDIR /tmp
RUN apk --update add build-base openssh curl autoconf zlib-dev curl-dev

# TODO: optimise compiled binary size
RUN mkdir -p /usr/src/git && \
	curl -o master.zip https://codeload.github.com/git/git/zip/master && unzip master.zip -d /usr/src/git && rm master.zip && \
	cd /usr/src/git/git-master && \
	make configure && \
	./configure NO_TCLTK=YesPlease NO_PERL=YesPlease NO_EXPAT=YesPlease NO_GETTEXT=YesPlease && \
	make install

# ---

FROM alpine AS final-image

RUN apk --update add openssh && \
	rm -rf /var/lib/apt/lists/* && \
	rm /var/cache/apk/*
	
COPY --from=compile-image /usr/local/bin/git* /usr/local/bin/

VOLUME /git
WORKDIR /git

ENTRYPOINT ["git"]
CMD ["--help"]