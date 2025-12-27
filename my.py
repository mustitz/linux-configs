#!/usr/bin/env python3

from collections import namedtuple
from utils import print_table

Server = namedtuple('Server', ['name', 'user', 'host', 'port'])

servers = [
    Server('funtoo', 'mustitz', 'mustitz.host.funtoo.org', 1022),
]

def make_ssh(server):
    sport = f'-p{server.port} ' if server.port else ''
    return f'ssh {sport}{server.user}@{server.host}'

def print_servers():
    names = [server.name for server in servers]
    cmds = [make_ssh(server) for server in servers]
    print_table(('NAME', 'SSH'), names, cmds)

def print_useful():
    print("Some useful commands:")
    print("  lsblk -o NAME,MAJ:MIN,SIZE,FSUSE%,TYPE,FSTYPE,MOUNTPOINT | grep -v '^loop'")
    print("  autossh -f -N mustitz@mustitz.host.funtoo.org -R 2222:localhost:22")

def main():
    print()
    print_servers()
    print()
    print_useful()

if __name__ == '__main__':
    main()
