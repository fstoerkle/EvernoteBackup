require "rake"

$:.push File.expand_path(File.dirname(__FILE__))

Signal.trap("INT") { exit 1 }

# run as follows
# $> rake backup destination=/path/to/output/dir

task :backup do
  require "evernote_backup.rb"
  EvernoteBackup.run! ENV["destination"]
end
