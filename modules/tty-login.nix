
{ config, lib, ... }:

let
  esc = builtins.fromJSON ''"\u001b"'';

  # Adjust these to match: stty size
  ttyRows = 50;
  ttyCols = 160;

  reset = "${esc}[0m";
  blue = "${esc}[1;34m";
  cyan = "${esc}[1;36m";
  lavender = "${esc}[1;35m";
  white = "${esc}[1;37m";

  # Recognizable NixOS snowflake in ASCII.
  logo = [
    "        __    ____    __"
    "       /  \\   \\   \\  /  \\"
    "       \\   \\   \\   \\/   /"
    "     ___\\   \\___\\      /"
    "    /            \\    /   /\\"
    "   /______________\\   \\  /  \\"
    "        /   /      \\   \\/   /"
    " ______/   /        \\  /   /___"
    "/         /          \\/        \\"
    "\\____    /\\          /   ______/"
    "    /   /  \\        /   /"
    "   /   /\\   \\______/___/_____"
    "   \\  /  \\   \\              /"
    "    \\/   /    \\____    ____/"
    "        /      \\   \\   \\"
    "       /   /\\   \\   \\   \\"
    "       \\__/  \\___\\   \\__/"
  ];

  logoTop =
    if ttyRows > 26
    then builtins.div (ttyRows - 26) 2
    else 2;

  leftFor = text:
    let
      col = builtins.div
        (ttyCols - builtins.stringLength text) 2;
    in
      if col < 0 then 1 else col + 1;

  cursor = row: col:
    "${esc}[${toString row};${toString col}H";

  centered = row: text:
    cursor row (leftFor text);

  # Backslashes must be escaped for agetty's issue parser.
  escapeIssue = text:
    lib.replaceStrings [ "\\" ] [ "\\\\" ] text;

  snowflake = lib.concatStringsSep ""
    (lib.imap0 (i: line:
      (centered (logoTop + i) line)
      + (if i < 9 then blue else cyan)
      + escapeIssue line
    ) logo);

  titleRow = logoTop + builtins.length logo + 2;
  hostRow = titleRow + 2;
  promptRow = hostRow + 4;

in
{
  services.getty.extraArgs = [
    "--nohostname"
    "--nohints"
  ];

  # Position both the artwork and the initial login prompt.
  # Keep the standard agetty and PAM authentication.
  environment.etc.issue = lib.mkForce {
    text =
      "${esc}[2J${esc}[H"
      + snowflake
      + centered titleRow "N I X O S"
      + lavender + "N I X O S"
      + centered hostRow config.networking.hostName
      + white + config.networking.hostName
      + centered promptRow "login: Gunter"
      + reset;
  };
}
