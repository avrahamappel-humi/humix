{ pkgs, config, ... }:

let
  inherit (config.nur.repos.rycee) firefox-addons mozilla-addons-to-nix;
in

{
  home.packages = [ mozilla-addons-to-nix ];

  # Configure work Firefox profile, and enable profile switcher
  programs.firefox =
    let
      defaults = config.firefoxProfileDefaults;

      local-addons = pkgs.callPackage ./generated-firefox-addons.nix {
        inherit (firefox-addons) buildFirefoxXpiAddon;
      };
    in

    {
      profiles.default.extensions = [ local-addons.profile-switcher ];
      profiles.work = defaults // {
        id = 1;
        extensions = defaults.extensions ++ [
          firefox-addons.angular-devtools
          firefox-addons.okta-browser-plugin
          local-addons.fellow
          local-addons.keeper-password-manager
          local-addons.profile-switcher
          # humi-feature-flag-portal
        ];
      };

      nativeMessagingHosts = [ (pkgs.callPackage ./firefox-profile-switcher-connector.nix { }) ];
    };

  # Required to get profile switcher to work in Firefox >= 124
  # see https://github.com/null-dev/firefox-profile-switcher/issues/106
  home.file."Library/Preferences/ax.nd.nulldev.FirefoxProfileSwitcher/config.json".text = /* json */ ''
    {"browser_binary": "/Applications/Firefox.app/Contents/MacOS/firefox"}
  '';
}
