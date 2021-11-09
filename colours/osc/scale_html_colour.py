#!/usr/bin/env python3

# Hex string <-> RGB conversion herein borrowed from webcolors library:
#    https://github.com/ubernostrum/webcolors/

import argparse
import re
from typing import NamedTuple, Tuple, Union


def main():
    parser = argparse.ArgumentParser(
        description='Scale hex colour to make it brighter or darker')
    parser.add_argument('rgb_hex_color', type=str,
                        help='Hex color (including #) to be scaled.')
    parser.add_argument('scalef', type=float,
                        help='The scale factor.')
    args = parser.parse_args()

    color_rgb = hex_to_rgb(args.rgb_hex_color)
    scaled_rgb = scale_rgb(color_rgb, args.scalef)

    print(rgb_to_hex(scaled_rgb), end='')


IntegerRGB = NamedTuple(
    "IntegerRGB", [("red", int), ("green", int), ("blue", int)])
HTML5SimpleColor = NamedTuple(
    "HTML5SimpleColor", [("red", int), ("green", int), ("blue", int)]
)
IntTuple = Union[IntegerRGB, HTML5SimpleColor, Tuple[int, int, int]]


def scale_rgb(rgb_triplet: IntegerRGB, scalef: float) -> IntTuple:
    return IntegerRGB._make(_normalize_integer_rgb(int(value * scalef)) for value in rgb_triplet)


def rgb_to_hex(rgb_triplet: IntTuple) -> str:
    """
    Convert a 3-tuple of integers, suitable for use in an ``rgb()``
    color triplet, to a normalized hexadecimal value for that color.
    """
    return "#{:02x}{:02x}{:02x}".format(*normalize_integer_triplet(rgb_triplet))


def hex_to_rgb(hex_value: str) -> IntegerRGB:
    """
    Convert a hexadecimal color value to a 3-tuple of integers
    suitable for use in an ``rgb()`` triplet specifying that color.
    """
    int_value = int(normalize_hex(hex_value)[1:], 16)
    return IntegerRGB(int_value >> 16, int_value >> 8 & 0xFF, int_value & 0xFF)


def normalize_integer_triplet(rgb_triplet: IntTuple) -> IntegerRGB:
    """
    Normalize an integer ``rgb()`` triplet so that all values are
    within the range 0-255 inclusive.
    """
    return IntegerRGB._make(_normalize_integer_rgb(value) for value in rgb_triplet)


HEX_COLOR_RE = re.compile(r"^#([a-fA-F0-9]{3}|[a-fA-F0-9]{6})$")


def normalize_hex(hex_value: str) -> str:
    """
    Normalize a hexadecimal color value to 6 digits, lowercase.
    """
    match = HEX_COLOR_RE.match(hex_value)
    if match is None:
        raise ValueError(
            "'{}' is not a valid hexadecimal color value.".format(hex_value)
        )
    hex_digits = match.group(1)
    if len(hex_digits) == 3:
        hex_digits = "".join(2 * s for s in hex_digits)
    return "#{}".format(hex_digits.lower())


def _normalize_integer_rgb(value: int) -> int:
    """
    Internal normalization function for clipping integer values into
    the permitted range (0-255, inclusive).
    """
    return 0 if value < 0 else 255 if value > 255 else value


if __name__ == "__main__":
    main()
