#!/usr/bin/env python3

import logging
import sys
from plumbum import local

from modules.ScriptHelpers import symlink_with_checks


def main():
    linkables = local['find']["-H", local.cwd.up(1), "-maxdepth", "3", "-name",
                              "*.symlink"]().split()
    logging.info("Found linkables: " + "\n".join(linkables))

    list(map(link_a_linkable, linkables))


def link_a_linkable(tgt):
    dest = local.env.home / ('.' + local.path(tgt).basename.strip(".symlink"))
    symlink_with_checks(local.path(tgt), dest)


if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    main()
