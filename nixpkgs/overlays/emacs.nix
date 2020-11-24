let
  flake = import ../default.nix;
in
import flake.inputs.emacs-overlay.outPath
