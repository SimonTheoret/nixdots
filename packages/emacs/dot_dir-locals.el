;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((nil . (
	 (eval . (setq consult-ripgrep-args (concat consult-ripgrep-args " -L --hidden ")))
	 (deadgrep-extra-arguments . '("--no-config --L --hidden"))
	 )
))

