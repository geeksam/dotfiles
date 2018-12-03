# Swiped from Keith at RealGeeks
git_collaborator() {
  sam="Sam Livingston-Gray <geeksam@gmail.com>"
  foo="Foo Foo <foo@foo.foo>"

  unset collaborated_with

  if [ -z ${1+x} ]; then
    collaborated_with=$keith
  else
    case "$1" in
      "keith")
        collaborated_with=$keith
        ;;

      "foo")
        collaborated_with=$foo
        ;;

      *)
        help="sam: $sam\nfoo: $foo"
        ;;
    esac
  fi

  if [ -z ${collaborated_with+x} ]; then
    printf "$help"
  else
    to_copy="Co-authored-by: $collaborated_with"
    echo $to_copy | pbcopy
    echo "$to_copy copied"
  fi
}

alias gcollab=git_collaborator
