let
  flake = import ../default.nix;
in
import flake.inputs.neovim-nightly-overlay.outPath
