config_file = File.join(File.dirname(__FILE__),
                        '..',
                        'config',
                        'application.yml')
app = Figaro::Application.new(path: config_file)
app.load
Figaro.application = app
