# Source:  https://github.com/jpalardy/dotfiles/blob/master/bash/completion/rake.sh
# Removed caching on the theory that I'll never remember to delete the cache file.

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_check_rakefile() {
  if [ ! -e Rakefile ]; then
    return
  fi

  # local cache_file=".cache_rake_t"
  # 
  # if [ ! -e "$cache_file" ]; then
  #   rake -T | awk '/^rake / {print $2}' > $cache_file
  # fi
  # 
  # local tasks=$(cat $cache_file)
  local tasks=$(rake -T | awk '/^rake / {print $2}')
  COMPREPLY=( $(compgen -W "${tasks}" -- $2) )
}
complete -F _check_rakefile -o default rake
