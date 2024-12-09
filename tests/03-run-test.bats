#!/usr/bin/env bats

@test "Run siege tests" {
  run siege -g localhost
  [ "$status" -eq 0 ]
  [[ "$output" == *"Connection refused"* ]]
}

@test "Run siege2csv test" {
  run siege2csv
  [ "$status" -eq 2 ]
  [[ "$output" == *"no data file specified"* ]]
}
