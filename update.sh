#!/usr/bin/env nix-shell
#!nix-shell -i bash -p npins node2nix
#
# Update dependencies

NODE_PKGS=(ngserver stylelint-lsp)

# Update the flake
echo "Updating flake inputs"
nix flake update

# Update npins sources
echo "Updating npins sources"
npins update

# Update Firefox addons
echo "Updating Firefox addons"
mozilla-addons-to-nix ./home-manager/addons.json \
  ./home-manager/generated-firefox-addons.nix

# Update node packages
echo "Updating Node packages"
for pkg in "${NODE_PKGS[@]}"
do
  echo "Updating $pkg..."
  cd "$pkg" || continue
  node2nix
  cd ..
done
