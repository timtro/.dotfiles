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

    scripts = local.cwd / "scr"

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
            "Check for pkg warnings! Package names change. Amend list as needed"
        )
        print("If you continue, the following packages will be installed:\n")
        print(pkgs)
        print()

        if user_says_yes("Would you like to install these packages?"):
            pkmgr.install(pkgs)

    if user_says_yes("Would you like to install atom and stared packages?"):
        mgr.ppa_install('ppa:webupd8team/atom', 'atom')
        local['apm']['stars', '--install'] & FG

    if user_says_yes("Install Neovim stable via ppa?")
        pkmgr.ppa_install('ppa:neovim-ppa/stable', 'neovim')
        local['nvim']['+PluginInstall', '+qall']
        sh[scripts / "setup_YCM.sh"]

    if user_says_yes("Would you like to install oh-my-zsh?"):
        sh[scripts / "install_zsh.sh"]

    if user_says_yes("Would you like to install gtk3 themes?"):
        git["-C", "/home/timtro/", "clone", "--verbose",
            "https://github.com/tliron/install-gnome-themes"] & FG
        local['/home/timtro/install-gnome-themes/install-gnome-themes'] & FG

    if user_says_yes("Would you like to install the papirus icons?"):
        pkmgr.ppa_install("ppa:papirus/papirus", ["papirus-icon-theme"])

    if user_says_yes("Would you like to install Variety?"):
        pkmgr.ppa_install("ppa:peterlevi/ppa", ["variety", "variety-slideshow"])

    if user_says_yes("Would you like to install Jupyter?"):
        pymgr.install("jupyter")

    if user_says_yes("Would you like to install Boomaga?"):
        pkmgr.ppa_install('ppa:boomaga/ppa', 'boomaga')


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

    args.add_argument(
        '--pkgs',
        dest='pkgs',
        metavar='PKGLST',
        default=None,
        help="A newline separated list of packages to install",
        nargs='+')

    args = args.parse_args()

    pkmgr = AptPackageManager()
    pymgr = PipPackageManager(pkmgr)

    logging.info("Pulling updates and upgrades.")
    try:
        pkmgr.update()
    except:
        logging.warning(
            "Update returned an error."
        )
    pkmgr.upgrade()

    git = checked_command(pkmgr, "git")
    wget = checked_command(pkmgr, "wget")
    curl = checked_command(pkmgr, "curl")
    sh = local["sh"]

    main(args.pkgs, pkmgr, pymgr)
