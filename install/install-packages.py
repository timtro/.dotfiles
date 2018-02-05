#!/usr/bin/env python3

from argparse import ArgumentParser
from plumbum import local, FG
from plumbum.cmd import sudo, echo
import logging
import sys
from plumbum.commands.processes import ProcessExecutionError
from functools import partial

from modules.ScriptHelpers import throw_if_nonexistant, user_says_yes, \
        user_reply, AptPackageManager, PipPackageManager, checked_command, pipe


def main(pkgs, pkmgr, pymgr):

    if user_says_yes("Configure git for timtro?"):
        git["config", "--global", "user.name", "timtro"]
        emailAddy = user_reply('Email address?: ')
        git["config", "--global", "user.email", emailAddy]

    if pkgs:
        files = list(map(throw_if_nonexistant, map(local.path, pkgs)))

        logging.info("Globally updating pip")
        pymgr.update()

        logging.info("Parsing package list.")
        pkgs = []
        for each in files:
            with open(each) as f:
                pkgs.append(
                    list(
                        pipe(f.readlines(),
                            partial(map, str.strip),
                            partial(filter, None),
                            partial(filter, is_not_comment),
                            partial(filter, pkmgr.is_valid_pkg))))
        pkgs = [item for sublist in pkgs for item in sublist]

        logging.warning(
            "Check for pkg warnings! Package names change. Amend list as needed")
        print("If you continue, the following packages will be installed:\n")
        print(pkgs)
        print()

        if user_says_yes("Would you like to install these packages?"):
            pkmgr.install(pkgs)

    if user_says_yes("Would you like to install Google's Chrome browser?"):
        install_chrome(pkmgr)

    if user_says_yes("Would you like to install atom and stared packages?"):
        install_atom(pkmgr)

    if user_says_yes("Would you like to clone .dotfiles from github?"):
        git["-C", "/home/timtro/", "clone", "--verbose",
            "https://github.com/timtro/.dotfiles"] & FG

    if user_says_yes("Would you like to install oh-my-zsh?"):
        install_oh_my_zsh(pkmgr)

    if user_says_yes("Would you like to install gtk3 themes?"):
        install_themes()

    if user_says_yes("Would you like to install the papirus icons?"):
        install_papirus(pkmgr)

    if user_says_yes("Would you like to install Variety?"):
        install_variety(pkmgr)

    if user_says_yes("Would you like to install Jupyter?"):
        pymgr.install("jupyter")

    if user_says_yes("Would you like to install powerline?"):
        # Must install from git due to Issue #34:
        #    https://github.com/powerline/powerline/issues/34
        # pymgr["install", "--user", "git+git://github.com/Lokaltog/powerline"]
        pymgr.install("git+git://github.com/Lokaltog/powerline")


def install_atom(mgr):
    mgr.ppa_install('ppa:webupd8team/atom', 'atom')
    local['apm']['stars', '--install'] & FG


def install_chrome(mgr):
    wget["https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"] & FG
    sudo[local['dpkg']['-i', 'google-chrome-stable_current_amd64.deb']] & FG
    local["rm"]["./google-chrome-stable_current_amd64.deb"] & FG



def install_oh_my_zsh(mgr):
    """
    Currently this throws at the end of the script, when it calls chsh.
    """
    mgr.install('zsh')
    try:
        (curl[
            "-fsSL",
            "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"]
         | sh) & FG
    except ProcessExecutionError:
        local['chsh']['-s', '/usr/bin/zsh'] & FG


def install_themes():
    git["-C", "/home/timtro/", "clone", "--verbose",
        "https://github.com/tliron/install-gnome-themes"] & FG
    local['/home/timtro/install-gnome-themes/install-gnome-themes'] & FG


def install_papirus(mgr):
    mgr.ppa_install("ppa:papirus/papirus", ["papirus-icon-theme"])


def install_variety(mgr):
    mgr.ppa_install("ppa:peterlevi/ppa", ["variety", "variety-slideshow"])


def is_comment(str):
    if "#" in str:
        return True
    else:
        return False


def is_not_comment(str):
    return not is_comment(str)


if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    args = ArgumentParser(
        description="Installs packages from a list to get a default Ubuntu installation up and running"
    )

    args.add_argument('--pkgs',
        dest = 'pkgs',
        metavar = 'PKGLST',
        default = None,
        help="A newline separated list of packages to install",
        nargs='+')

    args = args.parse_args()

    pkmgr = AptPackageManager()
    pymgr = PipPackageManager(pkmgr)

    logging.info("Pulling updates and upgrades.")
    pkmgr.update()
    pkmgr.upgrade()

    git = checked_command(pkmgr, "git")
    wget = checked_command(pkmgr, "wget")
    curl = checked_command(pkmgr, "curl")
    sh = local["sh"]

    main(args.pkgs, pkmgr, pymgr)
