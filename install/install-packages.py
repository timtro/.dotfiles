#!/usr/bin/env python3

from argparse import ArgumentParser
from plumbum import local, FG
from plumbum.cmd import sudo
import logging
import sys
from plumbum.commands.processes import ProcessExecutionError

from modules.ScriptHelpers import throw_if_nonexistant, user_says_yes, \
        user_reply, AptPackageManager, PipPackageManager, checked_command


def main(srcPath, pkmgr, pymgr):
    throw_if_nonexistant(local.path(srcPath))

    logging.info("Globally updating pip")
    pymgr.update()

    if user_says_yes("Configure git for timtro?"):
        git["config", "--global", "user.name", "timtro"]
        emailAddy = user_reply('Email address?: ')
        git["config", "--global", "user.email", emailAddy]

    logging.info("Parsing package list.")
    with open(str(srcPath)) as f:
        pkgs = list(
            filter(pkmgr.is_valid_pkg,
                   filter(is_not_comment,
                          filter(None, map(str.strip, f.readlines())))))

    logging.warning(
        "Check for pkg warnings! Package names change. Ammend list as needed")
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
        install_papirus()

    if user_says_yes("Would you like to install Variety?"):
        install_variety(pkmgr)

    if user_says_yes("Would you like to install Jupyter?"):
        sudo[pymgr["install", "jupyter"]]

    if user_says_yes("Would you like to install powerline?"):
        # Must install from git due to Issue #34:
        #    https://github.com/powerline/powerline/issues/34
        pymgr["install", "--user", "git+git://github.com/Lokaltog/powerline"]


def install_atom(mgr):
    mgr.ppa_install('ppa:webupd8team/atom', 'atom')
    local['apm']['stars', '--install'] & FG


def install_chrome(mgr):
    """
    TODO: Delete this shell code when the function has been tested.
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo apt update
    sudo apt install google-chrome-stable
    """
    (curl["-fsSL", 'https://dl-ssl.google.com/linux/linux_signing_key.pub'] |
     sudo['apt-key', 'add', '-']) & FG
    (sudo[echo["deb https://dl.google.com/linux/chrome/deb/ stable main"]]
     >> "/etc/apt/sources.list.d/google-chrome.list")()
    mgr.update()
    mgr.install(["google-chrome-stable"])


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
    local[local.env.home / '/install-gnome-themes/install-gnome-themes'] & FG


def install_papirus():
    (curl[
        "-fsSL",
        "https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh"]
     | sh) & FG


def install_variety(mgr):
    mgr.ppa_install("ppa:peterlevi/ppa", ["variety", "variety-slideshow"])


def is_comment(str):
    if "#" in str:
        return True
    return False


def is_not_comment(str):
    return not is_comment(str)


if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    args = ArgumentParser(
        description="Installs packages from a list to get a default Ubuntu installation up and running"
    )

    args.add_argument(
        'PKGLST', help="A newline separated list of packages to install")

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

    main(args.PKGLST, pkmgr, pymgr)
