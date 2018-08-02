FROM crystallang/crystal:0.25.1

# Install node/yarn/guard
RUN apt-get update && \
    apt-get install -y curl rubygems ruby-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && \
    apt-get install -y nodejs yarn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install guard guard-kemal guard-webpack

ENV APP /usr/src/app
RUN mkdir $APP
WORKDIR $APP

COPY shard.* $APP/
RUN shards

COPY package.json yarn.lock $APP/
RUN yarn

COPY . $APP/

CMD ["guard", "-i"]
