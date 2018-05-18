#!/usr/bin/env python3

import logging
import sys
from plumbum import local

from modules.ScriptHelpers import symlink_with_checks, UnavoidedCollision, user_says_yes


def main():

    link_dotfiles()
    link_incfg()

    # TODO:
    # * ln -s $HOME/.dotfiles/zsh/themes/timtros-agnoster.zsh-theme $HOME/.oh-my-zsh/themes/.
    # *

def link_dotfiles():
    linkables = local['find']["-H", local.cwd.up(1), "-maxdepth", "3", "-name",
                              "*.symlink"]().split()
    logging.info("Found linkable dotfiles:\n" + "\n".join(linkables))

    if user_says_yes("Proceed?"):
        linked = list(map(link_a_dotfile, linkables))
        for t, d in zip(linkables, linked):
            logging.info(t + " -> " + d)

def link_incfg():
    linkables = local['find']["-H", local.cwd.up(1), "-maxdepth", "3", "-name",
                              "*.incfg"]().split()
    logging.info("Found linkable ~/.config/ directories:\n"
            + "\n".join(linkables))

    if user_says_yes("Proceed, linking in `~/.config?`"):
        linked = list(map(link_an_incfg, linkables))
        for t, d in zip(linkables, linked):
            logging.info(t + " -> " + d)


def link_a_dotfile(tgt):
    dest = local.env.home / (
        '.' + local.path(tgt).basename.replace(".symlink", ""))
    return symlink_with_checks(local.path(tgt), dest)


def link_an_incfg(tgt):
    dest = local.env.home / ".config" / (
        local.path(tgt).basename.replace(".incfg", ""))
    return symlink_with_checks(local.path(tgt), dest)

if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    main()
