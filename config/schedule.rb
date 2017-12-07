# frozen_string_literal: true

rake_template = 'cd :path && bundle exec rake %<task>s --silent :output'

job_type :rake,
         format(rake_template, task: ':task')
job_type :change,
         format(rake_template, task: '"status:change[:from, :text, :emoji]"')
job_type :clear,
         format(rake_template, task: 'status:clear')
job_type :set,
         format(rake_template, task: '"status:set[:text, :emoji]"')

status_schedule = File.join(File.dirname(__FILE__), 'status_schedule.rb')
if File.exists? status_schedule
  instance_eval(File.read(status_schedule), status_schedule)
end
