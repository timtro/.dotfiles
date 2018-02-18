import logging
from plumbum import local, FG
from plumbum.cmd import sudo
from plumbum.commands.processes import ProcessExecutionError, CommandNotFound


def pipe(x, *funcs):
    """ pipe(x, f, g, h, …) = …(h(g(f(x))))"""
    for func in funcs:
        x = func(x)
    return x


def symlink_with_checks(f, t):
    logging.info("Symlinking directory " + f + " to " + t)
    throw_if_nonexistant(f)
    try:
        ask_to_delete_if_exists(t)
    except UnavoidedCollision:
        logging.warning("Unavoided collision. Skipping " + t)
        return ""
    f.symlink(t)
    return t.__str__()


def throw_if_nonexistant(p):
    if not p.exists():
        raise FileNotFoundError(p)
    else:
        return p


def ask_to_delete_if_exists(p):
    if p.exists():
        if user_says_yes("Would you like to delete, to avoid collision? " + p):
            delete_any(p)
        else:
            raise UnavoidedCollision(p)


def delete_any(p):
    if p.is_symlink():
        p.unlink()
    else:
        p.delete()


def user_says_yes(question):
    reply = input(question + ' (y/n): ').lower().strip()
    if reply in ["y", "ye", "yes"]:
        return True
    elif reply in ["n", "no"]:
        return False
    else:
        return user_says_yes("Invalid response. Please enter")


def user_reply(question):
    while True:
        reply = input(question).lower().strip()
        if len(reply) > 0:
            break


def checked_command(mgr, pkg, cmd=None):
    if cmd is None:
        cmd = pkg
    try:
        return local[cmd]
    except CommandNotFound:
        if mgr.is_valid_pkg(pkg):
            mgr.install(pkg)
            # Caution: will throw uncaught if cmd was not provided by pkg.
            return local[cmd]


class AptPackageManager:
    """
    This should be the reference for PackageManager interfaces. If this were
    C++ or Java, I would write an interface class.

    Because it's apt, ppa_install will be quite specific, and isn't part of the
    PackageManager interface.
    """
    apt = local['apt']

    def __getitem__(self, key):
        sudo[self.apt[key]] & FG

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
    def __init__(self, mgr):
        self.pip = checked_command(mgr, "python3-pip", "pip3")

    def __getitem__(self, key):
        self.pip[key] & FG

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
        sudo["-H"][self.pip["install", "--upgrade", "pip"]] & FG


class UnavoidedCollision(Exception):
    pass
