#!/usr/bin/env ruby

require 'yaml'
require 'pp'
require 'json'

conf = YAML.load_file('/tmp/in.yml')

puts JSON.pretty_generate(conf).gsub(":", " =>")

#pp conf
