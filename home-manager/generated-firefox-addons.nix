{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "fellow" = buildFirefoxXpiAddon {
      pname = "fellow";
      version = "2.6.9";
      addonId = "{80937ecd-75e5-4e2c-8ed2-2c011f53c452}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4350287/fellow-2.6.9.xpi";
      sha256 = "1c573e2797a2b605c0f84b7489ea00772c563eeccd1735fc2a4d72c55d5a0032";
      meta = with lib;
      {
        homepage = "https://fellow.app";
        description = "Bring Fellow into Google Meet and Google Calendar";
        mozPermissions = [
          "cookies"
          "storage"
          "https://*.fellow.app/*"
          "https://*.fellow.co/*"
          "https://meet.google.com/*"
          "https://calendar.google.com/*"
        ];
        platforms = platforms.all;
      };
    };
    "keeper-password-manager" = buildFirefoxXpiAddon {
      pname = "keeper-password-manager";
      version = "16.10.1";
      addonId = "KeeperFFStoreExtension@KeeperSecurityInc";
      url = "https://addons.mozilla.org/firefox/downloads/file/4343408/keeper_password_manager-16.10.1.xpi";
      sha256 = "41ff318af036bd4c4630a630060e380e549b392a15b53f081208597b005ab8f7";
      meta = with lib;
      {
        homepage = "http://keepersecurity.com/";
        description = "Protect and autofill passwords with the world's most trusted and #1 downloaded secure password manager and digital vault.";
        mozPermissions = [
          "contextMenus"
          "tabs"
          "alarms"
          "idle"
          "storage"
          "browsingData"
          "webNavigation"
          "http://*/*"
          "https://*/*"
          "webRequest"
          "webRequestBlocking"
          "<all_urls>"
          "https://keepersecurity.com/vault/*"
          "https://keepersecurity.eu/vault/*"
          "https://keepersecurity.com.au/vault/*"
          "https://keepersecurity.ca/vault/*"
          "https://keepersecurity.jp/vault/*"
          "https://govcloud.keepersecurity.us/vault/*"
        ];
        platforms = platforms.all;
      };
    };
    "profile-switcher" = buildFirefoxXpiAddon {
      pname = "profile-switcher";
      version = "1.3.1";
      addonId = "profile-switcher-ff@nd.ax";
      url = "https://addons.mozilla.org/firefox/downloads/file/3945999/profile_switcher-1.3.1.xpi";
      sha256 = "80ca410ad883a0a2a2dc50cb1f74474dd829223ce106a5911120461c30e4e64f";
      meta = with lib;
      {
        homepage = "https://github.com/null-dev/firefox-profile-switcher";
        description = "Create, manage and switch between browser profiles seamlessly.";
        license = licenses.gpl3;
        mozPermissions = [ "storage" "nativeMessaging" "tabs" ];
        platforms = platforms.all;
      };
    };
  }