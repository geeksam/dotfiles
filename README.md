These are my dotfiles.  There are many like them, but these ones are mine.

# Notes to Future Sams:

## New computer?

* Install Hammerspoon:  https://www.hammerspoon.org/
* clone this repo to ~/dotfiles
* `cd dotfiles`
* Set up shell helpers, aliases, config files, and so on:
  * `./symlink_all_the_things`
* Make sure homebrew is installed:  https://brew.sh/
  * Use homebrew to install the following:
    * neovim (?)
    * macvim (to get a reasonable version of Vim)
    * thefuck (because it's funny *and* useful)
    * bat (useful)
    * ack, the_silver_searcher, ripgrep (can't have too many grep alternatives!)
    * fzf (fuzzy finder)
    * blueutil (controls bluetooth, useful for hammerspoon automation)
* Launch vim and run `:PlugInstall`
* Install `asdf` from https://asdf-vm.com/guide/getting-started.html
  * as of Feb 2024 they recommend installing via Git, so if you do that, use
    the "Git + bash" instructions, not the "homebrew + bash" set
  * use `asdf` to install a Ruby
    * ???

<s>
x Install some Ruby version manager (probably rbenv):
  * rbenv: https://github.com/rbenv/rbenv
  * RVM: http://rvm.io/
  * asdf:
    * `brew install asdf`
    * `brew install openssl libyaml libffi` (required by the `asdf-ruby` plugin; note that this may cause some Ruby Woes below)
    * `asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git`
</s>

## Ruby Woes

### Trouble getting Ruby's `mysql2` gem to build properly?

You probably need to add a few hints about where stuff is.  (Obviously,
double-check the paths below; new computers may not need to run MySQL 5.6, for
example.)

* If mysql_config can't be found, try adding:
  `-- --with-mysql-config=/usr/local/opt/mysql@5.6/bin/mysql_config`
* If `-lss` can't be linked, try adding:
  `-- --with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include`

--

Clever ideas I could possibly implement at some point:

- add an indicator to the prompt showing whether the last command had an
  exit status of 0


