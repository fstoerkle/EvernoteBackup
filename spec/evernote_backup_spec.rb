
# add parent dir to include path
$: << File.expand_path(File.join(File.dirname(__FILE__), ".."))

require "evernote_backup.rb"
evernote = EvernoteBackup.new CONFIG["developer_key"], ENV["DESTINATION"]

describe EvernoteBackup, "#notebooks" do
  it "returns a list of notebooks" do
    evernote.notebooks.each do |notebook|
      expect(notebook).to be_an_instance_of(Evernote::EDAM::Type::Notebook)
    end
  end

  it "returns a non-empty list" do
    expect(evernote.notebooks.size).to be >= 1
  end
end