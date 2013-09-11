# evernote_backup.rb

# are this 'requires' necessary, since we do not implement OAuth anyways?
require "oauth"
require "oauth/consumer"

require "evernote_oauth"

# developer token (since only access to my personal account is needed)
# see https://sandbox.evernote.com/api/DeveloperToken.action
DEVELOPER_TOKEN = "..."

client = EvernoteOAuth::Client.new(token: DEVELOPER_TOKEN, sandbox: true)

notebooks = client.note_store.listNotebooks
notebooks.each { |notebook| puts "Notebook: #{notebook.name}" }
