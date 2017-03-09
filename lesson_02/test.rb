require 'yaml'
config = File.read('./rock_paper_lizard_config.yaml')
MESSAGES = YAML.load(config)

puts MESSAGES['bye']
