load $(basher package-path ztombol/bats-support)/load.bash
load $(basher package-path ztombol/bats-assert)/load.bash
load data

@test "does nothing without args" {
  run format
  assert_success
  assert_output ""
}

@test "does not write escape sequences if no format options" {
  run format -- "hello"
  assert_success
  refute_output --partial "\033["
}

@test "does not append reset sequence if no positional arguments" {
  run format dr B
  assert_success
  echo -n "\033[;1m" | assert_output

  run format dr r R --
  assert_success
  echo -n "\033[;31;7m" | assert_output
}

@test "does not append new line by default" {
  run format -- "hello"
  assert_success
  echo -n "hello" | assert_output
}

@test "always append reset sequence if format options" {
  run format b -- "hello"
  assert_success
  echo -ne "\033[0m" | assert_output --partial
}

@test "respects the order of options" {
  run format c ow S dr
  assert_success
  echo -n "\033[;36;47;9m" | assert_output

  run format ow S c dr
  assert_success
  echo -n "\033[;47;9;36m" | assert_output
}

@test "append new line with option" {
  run format nl -- "hello"
  assert_success
  echo "hello" | assert_output
}

@test "do not interpret with dry-run" {
  run format dr g -- "hello"
  assert_success
  assert_output "\033[;32mhello\033[0m"
}

@test "redirects to standard error" {
  run format er -- "hello"
  assert_success
  assert_output "hello"
}

@test "stops reading options after --" {
  run format -- nl "hello"
  assert_success
  echo -n "nl hello" | assert_output
}

@test "stop reading options after unmatched option" {
  run format hello g -- world
  assert_success
  echo -n "hello g -- world" | assert_output
}
