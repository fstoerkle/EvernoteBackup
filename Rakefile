require "rake"

$:.push File.expand_path(File.dirname(__FILE__))

# run as follows
# $> rake backup dest=/path/to/output/dir

task :backup do
  require "evernote_backup.rb"
  EvernoteBackup.run! ENV["dest"]
end
