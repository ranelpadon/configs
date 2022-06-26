"""
Custom theme based on the PuDB's bundled `midnight` theme.

Set in PuDB Preferences (Ctrl+P) as `~/dev/configs/.pudb.theme.py`.
"""

# Supported 16 color values:
#   'h0' (color number 0) through 'h15' (color number 15)
#    or
#   'default' (use the terminal's default foreground),
#   'black', 'dark red', 'dark green', 'brown', 'dark blue',
#   'dark magenta', 'dark cyan', 'light gray', 'dark gray',
#   'light red', 'light green', 'yellow', 'light blue',
#   'light magenta', 'light cyan', 'white'
#
# Supported 256 color values:
#   'h0' (color number 0) through 'h255' (color number 255)
#
# 256 color chart: http://en.wikipedia.org/wiki/File:Xterm_color_chart.png
#
# "setting_name": (foreground_color, background_color),

# See pudb/theme.py
# (https://github.com/inducer/pudb/blob/master/pudb/theme.py) to see what keys
# there are.

# Note, be sure to test your theme in both curses and raw mode (see the bottom
# of the preferences window). Curses mode will be used with screen or tmux.


# GitHub Source:
# https://github.com/inducer/pudb/blob/v2019.2/example-theme.py

# Local Sample:
# ~/.pyenv/versions/2.7.17/envs/ticketing/lib/python2.7/site-packages/pudb/theme.py


# ------------------------------------------------------------------------------
# Reference for some palette items:
#
#  "namespace" : "import", "from", "using"
#  "operator"  : "+", "-", "=" etc.
#                NOTE: Does not include ".", which is assigned the type "source"
#  "argument"  : Function arguments
#  "builtin"   : "range", "dict", "set", "list", etc.
#  "pseudo"    : "None", "True", "False"
#                NOTE: Does not include "self", which is assigned the
#                type "source"
#  "dunder"    : Class method names of the form __<name>__ within
#               a class definition
#  "exception" : Exception names
#  "keyword"   : All keywords except those specifically assigned to "keyword2"
#                ("from", "and", "break", "is", "try", "pass", etc.)
#  "keyword2"  : "class", "def", "exec", "lambda", "print"
# ------------------------------------------------------------------------------

# `brown` is equivalent to `orange`.

# The `palette` and `add_setting` references
# will be resolved by PuDB during runtime.

palette.update({
    "header": ("black", "light gray", "standout"),
    "focused sidebar": ("black", "light gray", "standout"),

    # {{{ variables view
    "variables": ("white", "default"),
    "variable separator": ("dark cyan", "light gray"),

    "var label": ("light blue", "default"),
    "var value": ("white", "default"),
    "focused var label": ("black", "dark green"),
    "focused var value": ("black", "dark green"),

    "highlighted var label": ("white", "dark cyan"),
    "highlighted var value": ("black", "dark cyan"),
    "focused highlighted var label": ("white", "dark green"),
    "focused highlighted var value": ("black", "dark green"),

    "return label": ("white", "dark blue"),
    "return value": ("black", "dark cyan"),
    "focused return label": ("light gray", "dark blue"),
    "focused return value": ("black", "dark green"),

    "stack": ("white", "default"),

    "frame name": ("white", "default"),
    "frame class": ("dark blue", "default"),
    "frame location": ("light green", "default"),
    # "frame location": ("light cyan", "default"),

    "current frame name": ("white", "default"),
    "current frame class": ("dark blue", "default"),
    "current frame location": ("brown", "default"),

    "focused frame name": ("black", "dark green"),
    # "focused frame class": (add_setting("white", "bold"), "dark green"),
    # "focused frame location": ("dark blue", "dark green"),
    "focused frame class": ("black", "dark green"),
    "focused frame location": ("black", "dark green"),

    "focused current frame name": ("black", "dark green"),
    "focused current frame class": ("black", "dark green"),
    "focused current frame location": ("black", "dark green"),

    "search box": ("default", "default"),

    "breakpoint": ("white", "default"),

    "breakpoint source": ("white", "dark red"),
    "breakpoint focused source": ("black", "dark red"),
    "disabled breakpoint": ("dark gray", "default"),
    "focused breakpoint": ("black", "dark green"),
    "focused disabled breakpoint": ("dark gray", "dark green"),
    "current breakpoint": ("white", "default"),
    "disabled current breakpoint": ("dark gray", "default"),
    "focused current breakpoint": ("white", "dark green"),
    "focused disabled current breakpoint": ("dark gray", "dark green"),

    # "source": ("white", "default"),
    # "highlighted source": ("white", "light cyan"),
    # "current source": ("white", "light gray"),
    # "current focused source": ("white", "brown"),
    "source": ("white", "default"),

    # RANEL: overrides.
    "highlighted source": ("black", "light cyan"),
    "current source": ("black", "light gray"),
    "current focused source": ("black", "brown"),

    # "line number": ("light gray", "default"),
    # "keyword": ("dark magenta", "default"),
    # "keyword2": ("light blue", "default"),
    # # "classname": ("dark cyan", "default"),
    # # "funcname": ("white", "default"),
    # "funcname": ("light blue", "default"),

    # "name": ("white", "default"),
    # "literal": ("dark cyan", "default"),

    # "string": ("dark red", "default"),
    # "doublestring": ("dark red", "default"),
    # "singlestring": ("light blue", "default"),
    # "docstring": ("light red", "default"),
    "string": ("light green", "default"),
    "doublestring": ("light green", "default"),
    "singlestring": ("light green", "default"),
    "docstring": ("light green", "default"),

    "line number": ("dark gray", "black"),

    "keyword2": ("light magenta", "black"),
    # "keyword2": ("light cyan", "black"),
    "name": ("light blue", "black"),
    # "name": ("light green", "black"),
    "literal": ("light magenta", "black"),

    "namespace": ("light red", "black"),
    "operator": ("light red", "black"),
    "argument": ("light red", "black"),
    # "argument": ("brown", "black"),
    "builtin": ("light cyan", "black"),
    "pseudo": ("light magenta", "black"),
    "dunder": ("light cyan", "black"),
    "exception": ("light cyan", "black"),
    "keyword": ("light blue", "black"),
    # "keyword": ("light red", "black"),

    "classname": ("brown", "default"),
    # "classname": ("yellow", "default"),
    "backtick": ("light green", "default"),
    "punctuation": ("white", "default"),
    # "comment": ("dark green", "default"),
    "comment": ("light gray", "default"),

    "breakpoint marker": ("dark red", "default"),

    # {{{ shell

    "command line edit": ("light green", "default"),
    "command line prompt": ("light blue", "default"),

    "command line input": ("light green", "default"),
    "command line output": ("white", "default"),
    "command line error": ("light red", "default"),

    "focused command line output": ("black", "dark green"),
    "focused command line input": ("black", "dark green"),
    "focused command line error": ("black", "dark green"),

    "command line clear button": ("white", "default"),
    "command line focused button": ("black", "light gray"),  # White
    # doesn't work in curses mode

})
