{pkgs, ...}:
{
     writeShellScriptBinBang = import [../lib/scripting.nix].writeShellScriptNix;
   calc = writeShellScriptBinBang "calc" ''
#!/usr/bin/env python3

import numpy as np
import scipy, math
import matplotlib.pyplot as plt
import IPython
import matplotlib
import tkinter
matplotlib.use("TkAgg")

print('This is scientific calculator.')
print('numpy is np and matplotlib.pyplot plt')

IPython.embed()
''
}
}
# {}
