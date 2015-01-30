#!/bin/bash

__FILE__="${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"
__DIR__=$(dirname "$__FILE__")
TMPDIR="$__DIR__/tmp"
mkdir -p $TMPDIR
STDOUT=`mktemp`
STDERR=`mktemp`
original_pwd="$PWD"

trap 'cd "$original_pwd"; rm -rf "$STDOUT"; rm -rf "$TDERR"; rm -rf "$TMPDIR"' exit

alias swapf="$__DIR__/../swapf"

before_each() {
  cd "$TMPDIR"
  echo -n a > a
  echo -n b > b
}
after_each() {
  cd "$original_pwd"
  rm -rf "$TMPDIR"
  mkdir "$TMPDIR"
}

it(){
  local msg="$1"
  local cmd="_(){ "$(cat)"; };_" #wrap into an immediately invokable function so we can use return
  local ret=0
  before_each
  if eval "$cmd" > "$STDOUT" 2> "$STDERR" ; then
    echo -en "OK\t"
    ret=0
  else
    echo -en "FAIL\t"
    ret=1
  fi;
  echo "$msg"
  after_each
  return "$ret"
}
assert() {
  eval "$1"
}

it "should swap two different files" <<'EOF'
  swapf a b
  [[ "$(cat a)" == "b" ]] && 
  [[ "$(cat b)" == "a" ]]
EOF

it "it should error out unless two args given" <<'eof'
  ! swapf a b c && ! swapf a && ! swapf
eof

it "it should error out if the same file is given" <<'eof'
  ! swapf a a
eof

