#!/usr/bin/env nix-shell
#!nix-shell -i bash -p node2nix
#
# Update dependencies

NODE_PKGS=(ngserver stylelint-lsp)

# Update the flake
nix flake update

# Update node packages
for pkg in "${NODE_PKGS[@]}"
do
  echo "Updating $pkg..."
  cd "$pkg" || continue
  node2nix
  cd ..
done
