FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git config --global init.defaultBranch main && \
    git config --global user.email "hugo@42.fr" && \
    git config --global user.name "Hugo Site"

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v0.137.0/hugo_0.137.0_linux-amd64.deb -o hugo.deb \
    && dpkg -i hugo.deb \
    && rm hugo.deb

WORKDIR /var/www/hugo

RUN rm -rf site

RUN echo hugo version is ...... && hugo version

COPY tools/init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

COPY tools/static/images/* /tmp/

EXPOSE 1313

ENTRYPOINT ["/usr/local/bin/init.sh"]