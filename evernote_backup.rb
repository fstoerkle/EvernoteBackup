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
      notebook_path = File.join(destination, self._MOVEUP_safe_path(notebook.name))
      Dir.mkdir notebook_path unless File.directory? notebook_path

      evernote.notes(notebook).each do |note|
        note_path = File.join(notebook_path, self._MOVEUP_safe_path(note.title)) + ".html"
        IO.write(note_path, note.content)
      end
    end
  end
end


