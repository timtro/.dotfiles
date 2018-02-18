#!/usr/bin/env python3

from argparse import ArgumentParser
from plumbum import local
import logging
import sys

from modules.ScriptHelpers import symlink_with_checks, throw_if_nonexistant


def main():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)

    srcPath = local.path(args.SRCPATH)
    destPath = local.path(args.DESTPATH)
    throw_if_nonexistant(srcPath)
    throw_if_nonexistant(destPath)

    logging.info("Unpacking " + srcPath + " to " + destPath)

    for target in ["Documents", "Pictures", "Videos", "Templates", "Music"]:
        set_up_gvfs_directory(srcPath / target, destPath / target)

    for target in ["workspace", "ipy_workbook", "src", "scr"]:
        symlink_with_checks(srcPath / target, destPath / target)

    for target in [".gourmet", ".astylerc", ".latexmkrc"]:
        symlink_with_checks(srcPath / target, destPath / target)

    symlink_with_checks(srcPath / ".fonts", destPath / ".fonts")
    logging.info("Building local font cache...")
    local["fc-cache"]["-f", destPath / ".fonts"]()

    symlink_with_checks(srcPath / "texmf", destPath / "texmf")
    logging.info("Running texhash...")
    local["texhash"][destPath / "texmf"]()


def set_up_gvfs_directory(f, t):
    gvfsName = f.stem.lower()
    if gvfsName in ["documents", "music", "pictures", "templates", "videos"]:
        symlink_with_checks(f, t)
        gvfsNameIdentifier = "folder-" + gvfsName
        print(gvfsNameIdentifier)
        gvfs_set_custom_icon_name(t, gvfsNameIdentifier)
    else:
        logging.warning("Skipped folder with no known GVFS attribute: " + f)


def gvfs_set_custom_icon_name(p, name):
    local["gvfs-set-attribute"][p, "metadata::custom-icon-name", name]()


if __name__ == '__main__':
    args = ArgumentParser(
        description='Unpacks my cloud folder into a Linux home directory')

    args.add_argument('SRCPATH', help='Source directory, (the cloud folder).')
    args.add_argument(
        'DESTPATH', help='Destination directory, (the home directory).')

    args = args.parse_args()

    main()
