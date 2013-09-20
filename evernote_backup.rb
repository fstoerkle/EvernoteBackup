#!/usr/bin/env ruby
# evernote_backup.rb

require "toml"
require "evernote_oauth"

CONFIG = TOML.load_file(ENV["HOME"]+"/.backups/evernote.toml")

class EvernoteBackup
  def initialize(developer_key, destination, sandbox=true)
    @token = developer_key
    @destination = destination

    client = EvernoteOAuth::Client.new(token: @token, sandbox: sandbox)
    @store = client.note_store
  end

  def notebooks
    @store.listNotebooks
  end

  def notes(notebook)
    notes = []

    filter = Evernote::EDAM::NoteStore::NoteFilter.new(notebookGuid: notebook.guid)
    result_spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new()
    notes_metadata = @store.findNotesMetadata(@token, filter, 0, 1000, result_spec)

    notes_metadata.notes.each do |note_metadata|
      notes << @store.getNote(@token, note_metadata.guid, true, false, false, false)
    end

    notes
  end

  def self._MOVEUP_safe_path(path)
    path.gsub(/[\s']/, "_")
  end
  
  def self.run!(destination)
    evernote = EvernoteBackup.new CONFIG["developer_key"], destination
    puts "Backing up Evernote to #{destination}"

    unless File.directory? destination
      Dir.mkdir destination 
      puts "Creating destination directory since it does not exist yet"
    end

    evernote.notebooks.each do |notebook|
      Dir.mkdir File.join(destination, self._MOVEUP_safe_path(notebook.name))

      evernote.notes(notebook).each do |note|
        puts " - #{note.title}"
      end
    end
  end
end


