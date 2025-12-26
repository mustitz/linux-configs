#!/usr/bin/env python3

from argparse import ArgumentParser
from pathlib import Path

from utils import print_table, print_separator

SOURCED_SH = Path.home() / '.chenv.sh'
VENV_DIR = Path.home() / 'venv'

_sources = []

def _source(line):
    _sources.append(line)

def _chenv():
    if not _sources:
        return

    with open(SOURCED_SH, 'w', encoding='utf-8') as f:
        for line in _sources:
            print(line, file=f)

    for line in _sources:
        print(line)

    print_separator()

def py_list_venvs():
    if not VENV_DIR.exists():
        print(f"No virtual environments directory found at {VENV_DIR}")
        return

    venvs = []
    for item in VENV_DIR.iterdir():
        if item.is_dir() and (item / 'pyvenv.cfg').exists():
            venvs.append(item.name)

    if venvs:
        print("Available virtual environments:")
        for venv in sorted(venvs):
            print(f"  {venv}")
    else:
        print(f"No virtual environments found in {VENV_DIR}")

def py_set_venv(name):
    if name is None:
        return py_list_venvs()
    _source(f"source {VENV_DIR}/{name}/bin/activate")

def main():
    parser = ArgumentParser(description="Change environment helper")
    subparsers = parser.add_subparsers(dest='command', help='Available commands')

    py_parser = subparsers.add_parser('py', help='Switch to python venv')
    py_parser.add_argument('name', nargs='?', help='Optional python venv name')

    args = parser.parse_args()

    if args.command == 'py':
        return py_set_venv(args.name)

    parser.print_help()

if __name__ == '__main__':
    main()
    _chenv()
