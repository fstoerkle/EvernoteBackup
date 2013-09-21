
# add parent dir to include path
$: << File.expand_path(File.join(File.dirname(__FILE__), ".."))

require "evernote_backup.rb"
evernote = EvernoteBackup.new ENV["DEVELOPER_KEY"], ENV["DESTINATION"]

describe "Environment" do
  it "provides the DEVELOPER_KEY and DESTINATION variables" do
    [ "DEVELOPER_KEY", "DESTINATION" ].each do |name|
      expect(ENV[name]).to_not be_nil
      expect(ENV[name].size).to be >= 1
    end
  end
end

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