require 'bundler'
Bundler.require

unless defined? PROJECT_ROOT
  PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

config_file = File.join(PROJECT_ROOT, 'config', 'application.yml')
app = Figaro::Application.new(path: config_file)
app.load
Figaro.application = app

def reload!
  $".select{|path| path.start_with? PROJECT_ROOT}.each do |path|
    load path
  end
end

require 'status_changer'
