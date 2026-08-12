{
  buildMozillaXpiAddon,
  fetchurl,
  lib,
  stdenv,
  ...
}: {
  "google-lighthouse" = buildMozillaXpiAddon {
    pname = "google-lighthouse";
    version = "100.0.0.3";
    addonId = "{cf3dba12-a848-4f68-8e2d-f9fadc0721de}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4148676/google_lighthouse-100.0.0.3.xpi";
    sha256 = "49cb8c94d536e1f49b76a3e75e8cd0c361961061da53039abbc5db755944afb9";
    meta = with lib; {
      homepage = "https://github.com/GoogleChrome/lighthouse";
      description = "Lighthouse is an open-source, automated tool for improving the performance, quality, and correctness of your web apps.";
      mozPermissions = ["activeTab" "storage"];
      platforms = platforms.all;
    };
  };
}
