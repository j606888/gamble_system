namespace :database do
  desc 'backup to s3'
  task :backup => :environment do
    DbBackup.call
    puts "[#{Time.now}] Backup success"
  end
end

# Restore
# pg_restore -Fc -c -d gamble_system_development <backup_file>