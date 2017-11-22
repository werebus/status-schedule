require 'bundler'
Bundler.require

unless defined? PROJECT_ROOT
  PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

def reload!
  $".select{|path| path.start_with? PROJECT_ROOT}.each do |path|
    load path
  end
end

require 'env'
require 'status_changer'
