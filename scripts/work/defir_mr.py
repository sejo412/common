#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import yaml
import git


def load_config(config_file):
    with open(config_file, 'r') as stream:
        try:
            config = yaml.load(stream)
        except yaml.YAMLError as exc:
            print(exc)
            config = None
    return config


if __name__ == "__main__":
    config = load_config("/Users/pavel/work/defir/.config.yml")
    repo = git.Repo(config['work_dir'])
    source_branch = repo.head.ref
    target_branch = config['target_branch']
    print(source_branch)
