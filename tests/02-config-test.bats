#!/usr/bin/env bats

@test "Check Siege config output" {
  run siege -C
  [ "$status" -eq 0 ]
  [[ "$output" == *"concurrent user"* ]]
}
