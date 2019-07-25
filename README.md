These are my dotfiles.  There are many like them, but these ones are mine.

# Notes to Future Sams:

## New computer?

* clone this repo to ~/dotfiles
* `cd dotfiles`
* Set up shell helpers, aliases, config files, and so on:
  * `./symlink_all_the_things`
* Make sure homebrew is installed:  https://brew.sh/
* Install `asdf` and use it to manage Ruby versions:
  * `brew install asdf`
  * `brew install openssl libyaml libffi` (required by the `asdf-ruby` plugin)
  * `asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git`
* Launch vim and run `:PlugInstall`

--

Clever ideas I could possibly implement at some point:

- add an indicator to the prompt showing whether the last command had an
  exit status of 0


