require "kemal"
require "./recolor/*"

get "/" do
  render "src/views/index.ecr", "src/views/layouts/layout.ecr"
end

Kemal.run
