{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "fellow" = buildFirefoxXpiAddon {
      pname = "fellow";
      version = "2.6.7";
      addonId = "{80937ecd-75e5-4e2c-8ed2-2c011f53c452}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4339258/fellow-2.6.7.xpi";
      sha256 = "481aa4c14f51cae685c5f8cfeccabb27e524f6048777349be04689e02e01196b";
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
      version = "16.10.0";
      addonId = "KeeperFFStoreExtension@KeeperSecurityInc";
      url = "https://addons.mozilla.org/firefox/downloads/file/4327837/keeper_password_manager-16.10.0_ImrxslG.xpi";
      sha256 = "7245b76152bbfdb48a256297c14b21511298f5e0c7470f3bddb298697911e997";
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
  }