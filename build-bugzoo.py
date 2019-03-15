import csv

import yaml

FN_BUGZOO_FILE = 'cbmultios.bugzoo.yml'
NAME_IMAGE = 'christimperley/cbmultios'
NAME_DATASET = 'cbmultios'
NUM_POLLS = 200


def describe_bug(name, num_povs):
    yml = {}
    yml['name'] = "cbmultios:{}".format(name)
    yml['image'] = NAME_IMAGE
    yml['dataset'] = NAME_DATASET
    yml['languages'] = ['C']
    yml['source-location'] = '/challenge/challenges/{}/src'.format(name)
    yml['test-harness'] = {
        'type': 'genprog',
        'command': '/challenge/test.sh {} __ID__'.format(name),
        'context': '/challenge',
        'time-limit': 30,
        'passing': NUM_POLLS,
        'failing': num_povs
    }
    yml['compiler'] = {
        'type': 'simple',
        'time-limit': 30,
        'context': '/challenge/build/challenges/{}'.format(name),
        'command': "make '{}'".format(name),
        'command_clean': "rm -f '{}'".format(name),
        'command_with_instrumentation': "TODO"
    }
    yml['coverage'] = {
        'type': 'gcov',
        'files-to-instrument': ['TODO']
    }
    return yml


def main():
    yml = {}
    yml['version'] = '1.0'
    yml['blueprints'] = [{
        'type': 'docker',
        'file': 'Dockerfile',
        'tag': NAME_IMAGE,
        'context': '.'}]
    yml['bugs'] = [
        describe_bug('Space-Attackers', 1)
    ]

    with open(FN_BUGZOO_FILE, 'w') as f:
        yaml.dump(yml, f)


if __name__ == '__main__':
    main()
