rake_template = 'cd :path && bundle exec rake %<task>s --silent :output'

job_type :rake,
         format(rake_template, { task: ':task' })
job_type :change,
         format(rake_template, { task: '"status:change[:from, :text, :emoji]"' })
job_type :clear,
         format(rake_template, { task: 'status:clear' })
job_type :set,
         format(rake_template, { task: '"status:set[:text, :emoji]"' })

#every :day, at: '8:00' do
#  change :status, from: '', text: 'At Transit', emoji: 'oncoming_bus'
#end

#every :day, at: '16:00' do
#  clear :status
#end
