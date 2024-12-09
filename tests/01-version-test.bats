#!/usr/bin/env bats

@test "Check Siege version" {
  run siege -V
  [ "$status" -eq 0 ]
  [[ "$output" == *"SIEGE"* ]]
}
