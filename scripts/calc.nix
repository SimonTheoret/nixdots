{ pkgs ? import <nixpkgs> { } }:
pkgs.writeShellApplication {
  name = "calc";

  runtimeInputs = with pkgs; [
    Python311
    python311Packages.numpy
    Python311Packages.scipy
    python311Packages.matplotlib
    python311Packages.tkinter
  ];

  text = ''
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
  '';
}
