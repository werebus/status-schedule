# frozen_string_literal: true

require 'bundler'
Bundler.require

unless defined? PROJECT_ROOT
  PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

def reload!
  $LOADED_FEATURES.select { |p| p.start_with? PROJECT_ROOT }.each do |path|
    load path
  end
end

require 'env'
require 'status_changer'
