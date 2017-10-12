require 'yaml'
require 'erb'
require 'mongoid'

config_file = File.expand_path("../../../config/mongoid.yml", __FILE__)
settings    = YAML.load(ERB.new(File.read(config_file)).result).with_indifferent_access
Mongoid.load_configuration(settings[Sinatra::Base.environment])
