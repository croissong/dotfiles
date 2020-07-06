ediff3() {
  if [ $# -ne 3 ]; then
    echo Usage: $0 local base other
    exit 1
  fi
  emacsclient -c -q --eval '(ediff-merge-with-ancestor "'$1'" "'$2'" "'$3'")'
}
