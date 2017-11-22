rake_template = 'cd :path && bundle exec rake %<task>s --silent :output'

job_type :rake,
         rake_template.format(task: ':task')
job_type :change,
         rake_template.format(task: '"status:change[:from, :text, :emoji]"')
job_type :clear,
         rake_template.format(task: 'status:clear')
job_type :set,
         rake_template.format(task: '"status:set[:text, :emoji]"')

#every :day, at: '8:00' do
#  change :status, from: '', text: 'At Transit', emoji: 'oncoming_bus'
#end

#every :day, at: '16:00' do
#  clear :status
#end
