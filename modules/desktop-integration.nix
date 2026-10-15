{ ... }:

{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web
      "x-scheme-handler/http" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "x-scheme-handler/https" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "text/html" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "application/xhtml+xml" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      # PDF
      "application/pdf" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      # Images
      "image/png" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "image/jpeg" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "image/webp" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "image/gif" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];

      "image/svg+xml" = [
        "org.qutebrowser.qutebrowser.desktop"
      ];
    };
  };
}
