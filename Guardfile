guard 'kemal', path: 'src', file: 'recolor.cr' do
  watch(%r{src/.*\.e?cr}) # watch all Crystal files and views
end
guard 'sass', input: 'sass', output: 'public/css', style: :compressed
guard 'process', name: 'minifyJS', command: ['bash', '-c', 'minify --js < public/js/recolor.js > public/js/recolor.min.js'] do
  watch('public/js/recolor.js')
end

