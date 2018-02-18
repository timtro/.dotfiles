#!/usr/bin/env python3

import logging
import sys
from plumbum import local

from modules.ScriptHelpers import symlink_with_checks, UnavoidedCollision, user_says_yes


def main():
    linkables = local['find']["-H", local.cwd.up(1), "-maxdepth", "3", "-name",
                              "*.symlink"]().split()
    logging.info("Found linkables:\n" + "\n".join(linkables))

    if user_says_yes("Proceed?"):

        linked = list(map(link_a_linkable, linkables))

        for t, d in zip(linkables, linked):
            logging.info(t + " -> " + d)

        git["clone", "https://github.com/VundleVim/Vundle.vim.git", local.env.
            home / ".vim/bundle/Vundle.vim"]
        local['vim']["+PluginInstall", "+qall"]


def link_a_linkable(tgt):
    dest = local.env.home / (
        '.' + local.path(tgt).basename.replace(".symlink", ""))
    return symlink_with_checks(local.path(tgt), dest)


if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    main()
