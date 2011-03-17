# Source:  https://github.com/jpalardy/dotfiles/blob/master/bash/completion/cap.sh
# Removed caching on the theory that I'll never remember to delete the cache file.

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_check_capfile() {
  if [ ! -e Capfile ]; then
    return
  fi

  # local cache_file=".cache_cap_t"
  # 
  # if [ ! -e "$cache_file" ]; then
  #   cap -T | awk '/^cap / {print $2}' > $cache_file
  # fi
  # 
  # local tasks=$(cat $cache_file)
  local tasks=$(cap -T | awk '/^cap / {print $2}')
  COMPREPLY=( $(compgen -W "${tasks}" -- $2) )
}
complete -F _check_capfile -o default cap
