#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import yaml
import git
from subprocess import Popen, PIPE, run
#import subprocess

def load_config(config_file):
    with open(config_file, 'r') as stream:
        try:
            config = yaml.load(stream)
        except yaml.YAMLError as exc:
            print(exc)
            config = None
    return config

def get_files(work_dir, source_branch, target_branch):
    ext_cmd = ["git", "log", "%s..%s" % (target_branch, source_branch),
              "--name-only", "--pretty="]
#    p = Popen(ext_cmd, cwd=work_dir, stdin=PIPE,
#                         stdout=PIPE, stderr=PIPE)
#    output, err = p.communicate()
#    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    output = run(ext_cmd, cwd=work_dir)
    return output


if __name__ == "__main__":
    config = load_config("/Users/pavel/work/defir/.config.yml")
    work_dir = config['work_dir']
    repo = git.Repo(work_dir)
    source_branch = repo.head.ref
    target_branch = config['target_branch']
#    files = get_files(work_dir, source_branch, target_branch)
    print(repo.head.reference.log()[-1])
    print(repo.commits())
