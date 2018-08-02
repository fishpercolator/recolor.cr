# Recolor.ink

This is a Kemal web application that powers https://recolor.ink/

## Installation

You'll need yarn and crystal installed. Webpack is used to compile the JS and CSS assets and is installed as a dependency by Yarn.

To get it running in a development environment, just do:

    yarn
    ./node_modules/webpack/bin/webpack.js
    crystal src/recolor.cr

### Using Guard

Development is easier if you use Guard, which watches for file changes and rebuilds things automatically. If you do this, you don't need to build anything yourself:

    yarn
    gem install guard guard-kemal guard-webpack
    guard

### Or, with Docker-compose

    docker-compose up

## Contributing

1. Fork it ( https://github.com/fishpercolator/recolor.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[pedantic-git]](https://github.com/pedantic-git) Rich Daley - creator, maintainer
.
