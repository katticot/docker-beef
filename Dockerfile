FROM  ubuntu:14.04


# Set default locale for the environment
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8:fr
ENV LC_ALL fr_FR.UTF-8


RUN  apt-get update \
     && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        libsqlite3-dev \
        software-properties-common sqlite3 \
     && apt-add-repository -y ppa:brightbox/ruby-ng \
     && apt-get update \
     && apt-get install -y \
        ruby2.3 \
        ruby2.3-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /opt

RUN git clone git://github.com/beefproject/beef.git

WORKDIR /opt/beef

RUN bundle install

EXPOSE 3000

CMD ["./beef"]
