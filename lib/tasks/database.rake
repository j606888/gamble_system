namespace :database do
  desc 'backup to s3'
  task :backup => :environment do
    database = "gamble_system_#{Rails.env}"
    backup_file = "#{database}-#{Time.now.strftime("%F")}.sql"
    `pg_dump -Fc -d #{database} -f #{backup_file}`
    `aws s3 cp #{backup_file} s3://j606888-postgres-backup/backups/#{backup_file}`
  end
end

# Restore
# pg_restore -Fc -c -d gamble_system_development <backup_file>