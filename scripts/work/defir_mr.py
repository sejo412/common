#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import json
import yaml
import git
import os
import sys
import tempfile
from requests import post
from subprocess import call

config_file = "/Users/pavel/work/defir/.config.yml"


def load_config(config_file):
    with open(config_file, 'r') as stream:
        try:
            config = yaml.load(stream)
        except yaml.YAMLError as exc:
            print("!!!!\nХуйня в йамле \"%s\":\n!!!!\n%s" % (config_file, exc))
            config = None
    return config

def choose_title(commits):
    print("Choose title for merge request from commits:")
    index = 1
    titles = {}
    commits.reverse()
    for commit in commits:
        if commit != "":
            titles[index] = commit
            print("[%i] %s" % (index,titles[index]))
            index += 1
    response = 0
    while response not in range(1, len(titles)+1):
        try:
            response = int(input("Enter 1..%s: " % (len(titles))))
        except KeyboardInterrupt:
            print("ctr-c is pressed")
            exit(0)
        except:
            print("Число, блеать! От %i до %i, блеать!" %
                  (1, len(titles)))
    return(titles[response])

if __name__ == "__main__":
    config = load_config(config_file)
    work_dir = config['work_dir']
    repo = git.Repo(work_dir)
    source_branch = str(repo.head.ref)
    target_branch = config['target_branch']
    token = config['token']
    url = config['url']
    assignee = config['assignee']
    headers = {
        "Private-Token": token,
        "Content-Type": "application/json"
    }
    post_data = {
        "source_branch": source_branch,
        "target_branch": target_branch,
        "assignee_id": assignee
    }

    try:
        repo.remotes.origin.refs[source_branch]
    except:
        print("Remote branch \"%s\" not exist" % (source_branch))
        print("Exiting")
        exit(1)
    origin = repo.remotes.origin
    origin.fetch()
    repo.heads[source_branch].set_tracking_branch(origin.refs[source_branch])
    origin.pull()
    origin.push()
    m_files = repo.git.log("%s..%s" % (target_branch, source_branch),
                                "--name-only", "--pretty=").split("\n")
    commits = repo.git.log("%s..%s" % (target_branch, source_branch),
                           "--pretty=%B").split("\n\n")
    m_roles = []
    m_envs = []
    m_cooks = []
    n_roles = []
    n_envs = []
    n_cooks = []
    text = ""
    for m_file in m_files:
        if "roles/" in m_file:
            m_roles.append(m_file)
        elif "environments/" in m_file:
            m_envs.append(m_file)
        elif "cookbooks/" in m_file:
            m_cooks.append(m_file)
    if len(m_roles) > 0:
        u_roles = list(set(m_roles))
        text += "chef_roles: "
        for role in u_roles:
            n_roles.append(load_config("%s/%s" % (work_dir, role))['name'])
        text += ", ".join(n_roles) + ";\n"
    if len(m_envs) > 0:
        u_envs = list(set(m_envs))
        text += "chef_environments: "
        for env in u_envs:
            n_envs.append(load_config("%s/%s" % (work_dir, env))['name'])
        text += ", ".join(n_envs) + ";\n"
    if len(m_cooks) > 0:
        text += "chef_cookbooks: "
        for cook in m_cooks:
            if cook.split("/")[1] not in n_cooks:
                n_cooks.append(cook.split("/")[1])
        text += ", ".join(n_cooks) + ";\n"
    text += "***\n"
    editor = os.environ.get('EDITOR','vim')
    cmd = [editor]
    if editor == "vim":
        cmd.append("+")
    initial_message = b"%b" % (text.encode())
    with tempfile.NamedTemporaryFile() as tf:
        tf.write(initial_message)
        tf.flush()
        cmd.append(tf.name)
        call(cmd)
        post_data['description'] = open(tf.name, "r").read()
        tf.close()
    post_data['title'] = choose_title(commits)
    r = post(url, json=post_data, headers=headers)
    print(r.content)
