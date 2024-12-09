#!/usr/bin/env bats
load '/bats-core/lib/bats-support/load'
load '/bats-core/lib/bats-file/load'

@test 'Test: /usr/local/bin/siege' {
  local _file='/usr/local/bin/siege'
  assert_exists ${_file}
  assert_file_executable ${_file}
  assert_size_not_zero ${_file}
}

@test 'Exists: /usr/local/bin/siege.config' {
  local _file='/usr/local/bin/siege.config'
  assert_exists ${_file}
  assert_file_executable ${_file}
  assert_size_not_zero ${_file}
}

@test 'Exists: /usr/local/bin/siege2csv' {
  local _file='/usr/local/bin/siege2csv'
  assert_exists ${_file}
  assert_file_executable ${_file}
  assert_size_not_zero ${_file}
}

@test 'Exists: /usr/local/bin/bombardment' {
  local _file='/usr/local/bin/bombardment'
  assert_exists ${_file}
  assert_file_executable ${_file}
  assert_size_not_zero ${_file}
}

@test 'Exists: /etc/siegerc' {
  local _file='/etc/siegerc'
  assert_exists ${_file}
  assert_size_not_zero ${_file}
}

@test 'Exists: /SIEGE-COPYING' {
  local _file='/SIEGE-COPYING'
  assert_exists ${_file}
  assert_size_not_zero ${_file}
}
