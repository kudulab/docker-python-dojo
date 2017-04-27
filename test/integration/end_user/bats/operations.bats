load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

# all the ide scripts are set

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "ide init finished"
  assert_line --partial "/ide/work"
  assert_line --partial "python2-ide"
  refute_output "root"
  assert_equal "$status" 0
}
@test "python is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"python --version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Python 2.7"
  assert_equal "$status" 0
}
@test "locust runs on command line" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"source /ide/virtualenvs/locust/bin/activate && pip install -r requirements.txt && locust --no-web --host http://localhost:8065 -c 5 -r 2 -n 10\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Percentage of the requests completed within given times"
  # exit code may be non-zero, there is no server to repond to requests. It should fail
  assert_equal "$status" 1
}
