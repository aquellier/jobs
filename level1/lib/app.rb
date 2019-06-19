require 'json'

path = File.expand_path('../../../data.json', __FILE__)
p path
JSON.parse(File.read(path))
