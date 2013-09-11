#!/usr/bin/env ruby
# evernote_backup.rb

require "toml"
require "evernote_oauth"

token = TOML.load_file(ENV["HOME"]+"/.backups/evernote.toml")["developer_key"]

class EvernoteBackup
  def initialize(developer_key, sandbox=true)
    @token = developer_key

    client = EvernoteOAuth::Client.new(token: @token, sandbox: sandbox)
    @store = client.note_store
  end

  def notebooks
    @store.listNotebooks
  end

  def notes(notebook)
    filter = Evernote::EDAM::NoteStore::NoteFilter.new(notebookGuid: notebook.guid)
    result_spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new()
    notes_metadata = @store.findNotesMetadata(@token, filter, 0, 1000, result_spec)

    notes = []
    notes_metadata.notes.each do |note_metadata|
      notes << @store.getNote(@token, note_metadata.guid, true, false, false, false)
    end

    notes
  end
end

evernote = EvernoteBackup.new token
evernote.notebooks.each do |notebook|
  puts "Notebook: #{notebook.name}"
  evernote.notes(notebook).each do |note|
    puts " - #{note.title}"
  end
end