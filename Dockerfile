FROM  ubuntu
#RUN groupadd --gid 1000 node \
#    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
ARG password
ENV password=$password

RUN  apt-get update \
     && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        libsqlite3-dev \
        software-properties-common sqlite3 \
     && apt-add-repository -y ppa:brightbox/ruby-ng \
     && apt-get update \
     && apt-get install -y \
        ruby2.4 \
        ruby2.4-dev vim \
        zlib1g-dev \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /opt

RUN git clone git://github.com/beefproject/beef.git && echo $password 
WORKDIR /opt/beef
RUN ls

#RUN TERM=xterm ./install
#RUN sed 's/passwd: "beef"/passwd: "$password"/' config.yaml && bundle install
#Todo add config.yml in docker context

EXPOSE 3000

CMD ["./beef"]
