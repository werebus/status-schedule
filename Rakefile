require 'bundler'
Bundler.require

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(this_dir, 'lib')

require 'env'
require 'status_changer'

namespace :status do
  changer = StatusChanger.new

  desc <<~DESC
    Change your Slack status.

    This task takes three arguments. The first is the name of the emoji
    that your current status must be in order for a change to happen. The
    second is your new status text. And, the third is the name of the
    emoji to use. All three arguments are optional. Ommiting the from argument
    means that your current status must be blank.
  DESC
  task :change, [:from, :text, :emoji] do |_task, args|
    changer.change(from: (args[:from] ? args[:from].to_sym : ''),
                   to: {text: args[:text], emoji: args[:emoji]})
  end

  desc 'Clear your Slack status.'
  task :clear do
    changer.clear
  end

  desc <<~DESC
    Set your Slack status.

    This task takes two arguments. The first is your new status text, and the
    second is the name of the emoji to use. Both arguments are optional.
    Ommiting both arguments is equivalent to `status:clear`
  DESC
  task :set, [:text, :emoji] do |_task, args|
    changer.set(text: args[:text], emoji: args[:emoji])
  end
end
