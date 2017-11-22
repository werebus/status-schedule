require 'bundler'
Bundler.require

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(this_dir, 'lib')

config_file = File.join(this_dir, 'config', 'application.yml')
app = Figaro::Application.new(path: config_file)
app.load
Figaro.application = app

require 'status_changer'

namespace :status do
  changer = StatusChanger.new
  task :change, [:from, :text, :emoji] do |_task, args|
    changer.change(from: args[:from].to_sym,
                   to: {text: args[:text], emoji: args[:emoji]})
  end

  task :clear do
    changer.clear
  end

  task :set, [:text, :emoji] do |_task, args|
    changer.set(text: args[:text], emoji: args[:emoji])
  end
end
