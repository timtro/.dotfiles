#!/usr/bin/env python3

from argparse import ArgumentParser
from plumbum import local, FG
from plumbum.cmd import sudo
from plumbum.commands.processes import ProcessExecutionError
import logging
import sys

from modules.ScriptHelpers import throw_if_nonexistant, user_says_yes, \
        user_reply

git = local["git"]
wget = local["wget"]
curl = local["curl"]
sh = local["sh"]
pip = local["pip3"]


def main(srcPath):
    throw_if_nonexistant(local.path(srcPath))

    mgr = AptPackageManager()
    pymgr = PipPackageManager()

    logging.info("Pulling updates and upgrades.")
    mgr.update()
    mgr.upgrade()
    logging.info("Installing git, curl and pip")
    mgr.install(["git", "curl", "python3-pip"])
    logging.info("Globally updating pip")
    pymgr.update()

    if user_says_yes("Configure git for timtro?"):
        git["config", "--global", "user.name", "timtro"]
        emailAddy = user_reply('Email address?: ')
        git["config", "--global", "user.email", emailAddy]

    logging.info("Parsing package list.")
    with open(str(srcPath)) as f:
        pkgs = list(
            filter(mgr.is_valid_pkg,
                   filter(is_not_comment,
                          filter(None, map(str.strip, f.readlines())))))

    logging.warning(
        "Check for pkg warnings! Package names change. Ammend list as needed")
    print("If you continue, the following packages will be installed:\n")
    print(pkgs)
    print()

    if user_says_yes("Would you like to install these packages?"):
        mgr.install(pkgs)

    if user_says_yes("Would you like to install atom and stared packages?"):
        install_atom(mgr)

    if user_says_yes("Would you like to clone .dotfiles from github?"):
        git["-C", "/home/timtro/", "clone", "--verbose",
            "https://github.com/timtro/.dotfiles"] & FG

    if user_says_yes("Would you like to install oh-my-zsh?"):
        install_oh_my_zsh()

    if user_says_yes("Would you like to install gtk3 themes?"):
        install_themes()

    if user_says_yes("Would you like to install the papirus icons?"):
        install_papirus()

    if user_says_yes("Would you like to install Variety?"):
        install_variety(mgr)

    if user_says_yes("Would you like to install Jupyter?"):
        sudo[pip["install", "jupyter"]]


class AptPackageManager:
    apt = local['apt']

    def is_valid_pkg(self, pkg):
        try:
            logging.info("Checking " + pkg)
            self.apt['show', pkg]()
        except ProcessExecutionError:
            logging.warning("Package " + pkg + " not found in apt repos.")
            return False
        return True

    def install(self, pkgs):
        sudo[self.apt["--yes", "install"][pkgs]] & FG

    def ppa_install(self, ppaAddress, pkgs):
        sudo[local['add-apt-repository']['--yes', ppaAddress]] & FG
        self.update()
        self.install(pkgs)

    def update(self):
        sudo[self.apt["update"]] & FG

    def upgrade(self):
        sudo[self.apt["upgrade"]] & FG


class PipPackageManager:
    pip = local['pip3']

    def is_valid_pkg(self, pkg):
        try:
            logging.info("Checking " + pkg)
            self.pip['show', pkg]()
        except ProcessExecutionError:
            logging.warning("Package " + pkg + " not found in pip repos.")
            return False
        return True

    def install(self, pkgs):
        sudo[self.pip["install"][pkgs]] & FG

    def update(self):
        sudo[self.pip["install", "--upgrade", "pip"]] & FG


def install_atom(mgr):
    # sudo[local['add-apt-repository']['--yes', 'ppa:webupd8team/atom']] & FG
    # mgr.update()
    # mgr.install(['atom'])
    ppa_install('ppa:webupd8team/atom', 'atom')
    local['apm']['stars', '--install'] & FG


def install_chrome(mgr):
    """
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


def install_oh_my_zsh():
    (curl[
        "-fsSL",
        "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"]
     | sh) & FG


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

    main(args.PKGLST)
