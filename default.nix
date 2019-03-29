{ pkgs ? import (import ./fetch-nixpkgs.nix) {}
}:
let
  emacs = import ./emacs (with pkgs;
    { inherit
        makeWrapper
        symlinkJoin
        ;
      emacsPackagesNg = pkgs.emacsPackagesNg;
    });
  homies =
    [
      emacs
    ];
  LANG="en_US.UTF-8";
in
  if pkgs.lib.inNixShell
  then pkgs.mkShell
    { buildInputs = homies;}
  else homies
