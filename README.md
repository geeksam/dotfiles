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
    * jordanbaird-ice (Bartender replacement)
* Launch vim and run `:PlugInstall`
* Install some Ruby version manager:
  * rv: https://github.com/spinel-coop/rv?tab=readme-ov-file
  * rbenv: https://github.com/rbenv/rbenv
  * RVM: http://rvm.io/

## Ruby Woes

### Trouble getting Ruby's `mysql2` gem to build properly?

You probably need to add a few hints about where stuff is.  (Obviously,
double-check the paths below; new computers may not need to run MySQL 5.6, for
example.)

* If mysql_config can't be found, try adding:
  `-- --with-mysql-config=/usr/local/opt/mysql@5.6/bin/mysql_config`
* If `-lss` can't be linked, try adding:
  `-- --with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include`
