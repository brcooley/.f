#!/usr/bin/env python
"""Generic shell runner that caches results of a command.

Adapted from https://bitbucket.org/sivann/runcached/src/master/runcached.py
"""

from __future__ import print_function

import argparse
import hashlib
import os
import subprocess
import sys
import time

CACHE_DIR = '/tmp/runcached'
EXISTING_COMMAND_TIMEOUT_SEC = 30


def persistant_file(cmd_hash, cmd_shard, suffix):
  return os.path.join(CACHE_DIR, '%s-%s.%s' % (cmd_hash, cmd_shard, suffix))


def file_contents(filename):
  with open(filename) as f:
    return f.read()


def run_cmd(cmd, cmd_hash, cmd_shard, cache_ttl):
  cur_time = int(time.time())
  output_file = persistant_file(cmd_hash, cmd_shard, 'output')
  exit_code_file = persistant_file(cmd_hash, cmd_shard, 'exitcode')

  # If we don't have a cached result (or the result is too old), run cmd
  if (not os.path.isfile(output_file) or
      cur_time - int(os.path.getmtime(output_file)) > cache_ttl):
    # print('RUNNING CMD: |%s|' % cmd, file=sys.stderr)
    with open(output_file, 'w') as f:
      exit_code = subprocess.call(cmd, stdout=f, stderr=f, shell=True)
      with open(exit_code_file, 'w') as g:
        g.write(str(exit_code))

  # Now, return the just-ran or cached run result
  exit_code = None
  output = None
  with open(exit_code_file, 'r') as f:
    exit_code = int(f.read())
  with open(output_file, 'r') as f:
    output = f.read()

  return (exit_code or 0, output or '')


def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('-t', '--ttl_secs', type=int, default=60,
                      help='How long (in seconds) to cache results')
  parser.add_argument(
      'cmd', help='Command to execute. Should be a valid bash command')
  args = parser.parse_args()
  if not os.path.exists(CACHE_DIR):
    os.makedirs(CACHE_DIR)

  cmd = args.cmd
  cmd_shard = cmd.split()[0][:8]
  cmd_hash = hashlib.sha1(cmd).hexdigest()[:8]

  pid_file = persistant_file(cmd_hash, cmd_shard, 'pid')

  # Don't run the same command in parallel, wait for the previous invocation to
  # finish or a timeout to occur (EXISTING_COMMAND_TIMEOUT_SEC)
  retries = 5
  retries_left = retries
  while retries_left and os.path.isfile(pid_file):
    # Remove stale PID file if left there without a running process
    old_pid = file_contents(pid_file).strip()
    if not os.path.exists(os.path.join('/proc', old_pid)):
      os.remove(pid_file)

    time.sleep(EXISTING_COMMAND_TIMEOUT_SEC / retries)
    retries_left -= 1

  if os.path.isfile(pid_file):
    print('Timeout waiting for "%s" to finish. (pid: %s)' % (cmd, pid_file))
    sys.exit(1)

  # Write pid
  with open(pid_file, 'w') as f:
    print(os.getpid(), file=f)

  exit_code, output = run_cmd(cmd, cmd_hash, cmd_shard, args.ttl_secs)
  print(output, end='' if output.endswith('\n') else '\n')

  # Cleanup
  os.remove(pid_file)
  sys.exit(exit_code)


if __name__ == '__main__':
  main()
