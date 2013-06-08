#!/usr/bin/python

import os
import re

from os import path

def customize(source):
    with open(source, 'r') as f, open(source + ".custom", 'w') as tmp:
        for line in f:
            tmp.write(replace(line, source))

def replace(line, source):
    while '{{CUSTOM}}' in line:
        print 'In {0}, I found "{1}"'.format(path.basename(source), line.strip())
        if line.count('{{CUSTOM}}') > 1:
            print 'What should I replace the first {{CUSTOM}} with?'
        else:
            print 'What should I replace {{CUSTOM}} with?'

        replacement = raw_input('--> ')
        line = line.replace('{{CUSTOM}}', replacement)
        print '--------'
    return line

if __name__ == "__main__":
    dotosaurus = os.environ.get('DOTOSAURUS', os.path.expanduser('~/.dotosaurus'))
    sources = [f for f in os.listdir(dotosaurus) if f.endswith('.src')]

    for source in sources:
        customize(path.join(dotosaurus, source))
