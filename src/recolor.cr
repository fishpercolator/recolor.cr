require "kemal"
require "./recolor/*"

get "/" do
  render "src/views/index.ecr", "src/views/layouts/layout.ecr"
end

get "/about" do
  render "src/views/about.ecr", "src/views/layouts/layout.ecr"
end

# FIXME - make this nicer and have error-checking
post "/upload" do |env|
  file = env.params.files["svg"]
  filename = file.filename.to_s
  color = env.params.body["color"]
  env.response.content_type = "application/json"
  {data: SvgColorizer.new(file.tempfile).colorize_as_data(color), filename: filename}.to_json
end

Kemal.run
