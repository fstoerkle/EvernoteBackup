EvernoteBackup [![Build Status](https://secure.travis-ci.org/fstoerkle/EvernoteBackup.png)](http://travis-ci.org/fstoerkle/EvernoteBackup)
==============

Small ruby script creating a backup for all Evernote notes

Configuration
-------------
The config file is expected to be located at ~/.backups/evernote.toml.

There is only one thing configurable at the moment - the Evernote API developer key which is used for authentication:
```toml
developer_key = "..."
```
You can find the developer key for the Evernote Sandbox at https://sandbox.evernote.com/api/DeveloperToken.action.


Usage
-----
Make sure you have create the configuration correctly (see above).
To start the backup process just run this command:
```
$> ./evernote_backup.rb <OUTPUT_DIR>
```
This might take a while, depending on the number and content of your notes.
After finishing, you should have a fresh copy of your Evernote notes in the OUTPUT_DIR you specified.


License
-------
The MIT License (MIT), Copyright (c) 2013 Florian Störkle (see [LICENSE](LICENSE) file)
