#!/usr/bin/env python3

# from plumbum import local
import logging
import sys

from modules.ScriptHelpers import symlink_with_checks


def main():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)

    # linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )

    for target in linkables:
        symlink_with_checks(srcPath / target, destPath / target)


if __name__ == '__main__':
    main()
