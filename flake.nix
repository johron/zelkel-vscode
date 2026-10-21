{
  description = "NixOS Flake for VS Code Language Extension Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_22
            corepack
            git
            vsce            
          ];

          shellHook = ''
            export NPM_CONFIG_PREFIX=$PWD/.npm-packages
            export PATH=$PWD/.npm-packages/bin:$PATH

            if [ ! -f .npm-packages/bin/yo ]; then
              npm install -g yo generator-code --quiet
            fi
          '';
        };
      });
}
