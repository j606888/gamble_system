class DbBackup < ServiceCaller
  S3_BUCKET = 'j606888-postgres-backup'
  S3_PATH = 'backups'
  BACKUP_FOLDER = "#{Rails.root}/tmp/database"

  def initialize
  end

  def call
    FileUtils.mkdir_p(BACKUP_FOLDER) unless File.directory?(BACKUP_FOLDER)
    dump_postgres
    upload_to_s3
    remove_tmp_file
  end

  private
  def dump_postgres
    database = "gamble_system_#{Rails.env}"
    @file_key = "#{database}-#{Time.now.strftime("%F")}.sql"
    @file_path = "#{BACKUP_FOLDER}/#{@file_key}"
    `pg_dump -Fc -d #{database} -f #{@file_path}`
  end

  def upload_to_s3
    resource = Aws::S3::Resource.new
    s3_client = resource.bucket(S3_BUCKET).object("#{S3_PATH}/#{@file_key}")
    s3_client.upload_file(@file_path)
  end

  def remove_tmp_file
    File.delete(@file_path)
  end
end