#!/usr/bin/python

import os
import string
from os import path

class DotosaurusTemplate(string.Template):
    delimiter = '$::'

def parse_props(props_path):
    props = {}
    with open(props_path, 'r') as f:
        prop_lines = [x for x in f if x.strip() and not x.startswith('#')]
        for line in prop_lines:
            key, _, value = line.partition('=')
            props[key.strip()] = value.strip()
    
    return props

def build(template, work_dir):
    name = path.splitext(path.basename(template))[0]

    default_path = path.join(work_dir, 'default', name + ".dict")
    custom_path = path.join(work_dir, 'custom', name + ".dict")
    props = {}
    if path.isfile(default_path):
        props.update(parse_props(default_path))
    if path.isfile(custom_path):
        props.update(parse_props(custom_path))

    output_path = path.join(work_dir, 'build', name)

    with open(output_path, 'w') as out:
        with open(template, 'r') as src:
            for line in src:
                out.write(DotosaurusTemplate(line).substitute(props))

        custom_template = path.join(work_dir, 'custom', name + ".src")
        if path.isfile(custom_template):
            with open(custom_template, 'r') as src:
                for line in src:
                    out.write(DotosaurusTemplate(line).substitute(props))


if __name__ == "__main__":
    dotosaurus = os.environ.get('DOTOSAURUS', os.path.expanduser('~/.dotosaurus'))
    templates = [path.join(dotosaurus, t) for t in os.listdir(dotosaurus) if t.endswith('.src')]
    for template in templates:
        print "Processing template at {0}...".format(template)
        build(template, dotosaurus)
