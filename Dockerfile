FROM crystallang/crystal:1.7.3

# Install node/yarn/guard
RUN apt-get update && \
    apt-get install -y curl gnupg rubygems ruby-dev && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install guard guard-kemal guard-webpack
RUN npm install --global yarn

ENV APP /usr/src/app
RUN mkdir $APP
WORKDIR $APP

COPY shard.* $APP/
RUN shards

COPY package.json yarn.lock $APP/
RUN yarn

COPY . $APP/

CMD ["guard", "-i"]
