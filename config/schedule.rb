set :output, 'log/cron.log'
set :environment, ENV['RAILS_ENV']

if ENV['RAILS_ENV'] == 'production'
  every 1.day, at: '04:00 am' do
    rake 'database:backup'
  end
end