import logging


class UnavoidedCollision(Exception):
    pass


def symlink_with_checks(f, t):
    logging.info("Symlinking directory " + f + " to " + t)
    throw_if_nonexistant(f)
    try:
        ask_to_delete_if_exists(t)
    except UnavoidedCollision:
        logging.warning("Unavoided collision. Skipping " + t)
        return
    f.symlink(t)


def throw_if_nonexistant(p):
    if type(p) is list or type(p) is tuple:
        for path in p:
            if not path.exists():
                raise FileNotFoundError(path)
    else:
        if not p.exists():
            raise FileNotFoundError(p)


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
