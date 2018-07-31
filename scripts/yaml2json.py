#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import yaml
import json


def yaml_read(file_in):
    with open(file_in, 'r') as stream:
        try:
            data = yaml.load(stream)
        except yaml.YAMLError as exc:
            print(exc)
    return data


if __name__ == "__main__":
    obj = yaml_read('/tmp/in.yml')
    print(json.dumps(obj, indent=2))
