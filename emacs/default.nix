{ emacsPackagesNg, symlinkJoin, makeWrapper }:
let
  emacs = (with emacsPackagesNg;
           emacsWithPackages
           (with melpaPackages; [
                 ag
                 hindent
                 intero
                 ivy
                 magit
                 nix-mode
                 powerline
                 railscasts-reloaded-theme
                 smex
                 use-package
                 ]));
in symlinkJoin {
  name = "emacs";
  buildInputs = [makeWrapper];
  paths = [ emacs ];
  postBuild = ''
    wrapProgram "$out/bin/emacs" \
        --add-flags "-q -l ${./init.el}"
  '';
}

