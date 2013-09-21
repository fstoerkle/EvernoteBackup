require "rake"
require "rspec/core/rake_task"


# Initializations
# ----------------

# add . to include path
$:.push File.expand_path(File.dirname(__FILE__))

# smooth exit without strack traces on sending the INT signal (e.g. by pressing <ctrl>-<c>)
Signal.trap("INT") { exit 1 }

# set ./test_backup as default backup directory
# (used if no other destination is set as environtment variable)
ENV["destination"] ||= File.join(File.expand_path(File.dirname(__FILE__)), "test_backup")



# Task definitions
# ----------------

# per default, run the RSpec tests
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

# perform the backup
task :backup do
  # run as follows
  # $> rake backup destination=/path/to/output/dir

  require "evernote_backup.rb"
  EvernoteBackup.run! ENV["destination"]
end
