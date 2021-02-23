# print 'Executing .pdbrc.py...'
# locals()
# whatis num
# source _generate_primes
# math.

import pdb


class Config(pdb.DefaultConfig):
    editor = 'nano'
    stdin_paste = 'epaste'
    # filename_color = pdb.Color.lightgray
    use_terminal256formatter = False
    # exec_if_unfocused = "play ~/sounds/dialtone.wav 2> /dev/null &"

    # Ranel's Custom
    # https://github.com/pdbpp/pdbpp
    # https://pypi.org/project/pdbpp/#config-option
    # prompt = '(Ranel Pdb++) '
    prompt = '(Pdb++) '
    highlight = True
    encoding = 'utf-8'
    sticky_by_default = True
    filename_color = pdb.Color.yellow
    line_number_color = pdb.Color.turquoise
    current_line_color = "39;49;7"
    use_pygments = True
    bg = 'dark'
    show_traceback_on_error = True
    show_traceback_on_error_limit = None

    # interact
    # Start an interative interpreter whose global namespace contains all the names found in the current scope.

    def __init__(self):
        # import readline
        # readline.parse_and_bind('set convert-meta on')
        # readline.parse_and_bind('Meta-/: complete')

        try:
            from pygments.formatters import terminal
        except ImportError:
            pass
        else:
            self.colorscheme = terminal.TERMINAL_COLORS.copy()
            self.colorscheme.update({
                terminal.Keyword:            ('darkred',     'red'),
                terminal.Number:             ('darkyellow',  'yellow'),
                terminal.String:             ('brown',       'green'),
                terminal.Name.Function:      ('darkgreen',   'blue'),
                terminal.Name.Namespace:     ('teal',        'cyan'),
            })

    def setup(self, pdb):
        # Override keys.
        # make 'l' an alias to 'longlist'
        Pdb = pdb.__class__
        Pdb.do_l = Pdb.do_longlist
        Pdb.do_wi = Pdb.do_whatis
        Pdb.do_t = Pdb.do_whatis
        Pdb.do_st = Pdb.do_sticky
