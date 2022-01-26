FROM crystallang/crystal:1.3.2

# Install node/yarn/guard
RUN apt-get update && \
    apt-get install -y curl nodejs rubygems ruby-dev yarnpkg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install guard guard-kemal guard-webpack

ENV APP /usr/src/app
RUN mkdir $APP
WORKDIR $APP

COPY shard.* $APP/
RUN shards

COPY package.json yarn.lock $APP/
RUN yarnpkg

COPY . $APP/

CMD ["guard", "-i"]
