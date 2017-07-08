guard 'kemal', path: 'src', file: 'recolor.cr' do
  watch('src/recolor.cr') # watch the main kemal server
  watch(%r{src/.*\.ecr}) # watch your views
end
guard 'sass', input: 'sass', output: 'public/css'
