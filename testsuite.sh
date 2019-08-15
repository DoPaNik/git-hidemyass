#!/usr/bin/env bash

HIDEMYASS=git-hidemyass

setUp() {
    sudo make install
}

tearDown() {
    sudo make uninstall
}

testGitDefaultUser(){
  GIT_USER=$(git config user.name)
  GIT_EMAIL=$(git config user.email)

  echo "check default user name: $GIT_USER"
  assertEquals "git user name is not correct" \
    "$GIT_USER" "Travis CI User"

  echo "check default user name: $GIT_EMAIL"
  assertEquals "git user email is not correct" \
    "$GIT_EMAIL" "travis@example.org"
}

testHiding() { 
  git-hidemyass

  CHANGED_GIT_USER=$(git config user.name)
  CHANGED_GIT_EMAIL=$(git config user.email)

  echo "new user name: $CHANGED_GIT_USER"
  assertNotEquals "git user name not changed" \
    "$CHANGED_GIT_USER" "Travis CI User"

  echo "new user email:$CHANGED_GIT_EMAIL"
  assertNotEquals "git user email not changed" \
    "$CHANGED_GIT_EMAIL" "travis@example.org"
}

testBadInputs() {
  actual_stdout=$(git-hidemyass too many arguments passed)
  if grep -q Usage <<< $actual_stdout ; then
    found=true
    else 
    found=false
  fi
  assertTrue "unexpected response when passing bad inputs" \
    "$found"
}

. shunit2