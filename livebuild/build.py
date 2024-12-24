#!/usr/bin/python3
import subprocess
import os
import sys

def run_command(command):
    stderr=subprocess.STDOUT
    process = subprocess.Popen(command,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE,
                               shell=True,
                               universal_newlines=True)
    while process.poll() is None:
        line = process.stdout.readline().strip()
        if line:
            print(line)

    return process.returncode

def clone_repo():
    command = "git clone https://github.com/NekoSekaiMoe/asus_linux_debian_test ci --depth=1"
    run_command(command)


def build_repo():
    if os.path.exists(/deb)
        command = "mv -v /deb/*.deb ci/live-build/config/packages.chroot/ && cd ci/live-build && lb config && lb build"
    else
        command = "cd ci/live-build && lb config && lb build"
    run_command(command)


def main():
    clone_repo()
    build_repo()


if __name__ == '__main__':
    main()
