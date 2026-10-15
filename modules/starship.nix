{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      # Information on the first line.
      # Actual command input starts on a fresh second line.
      format = "$username$directory$git_branch$git_status$time$line_break$character";

      username = {
        show_always = true;

        style_user = "fg:#FFFFFF bg:#B65CDB";
        style_root = "fg:#FFFFFF bg:#FF5C8A";

        format = "[ $user ]($style)[](fg:#B65CDB bg:#E56AA6)";
      };

      directory = {
        style = "fg:#FFFFFF bg:#E56AA6";

        format = "[ $path ]($style)[](fg:#E56AA6 bg:#6F7CFF)";

        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = " ";

        style = "fg:#FFFFFF bg:#6F7CFF";

        format = "[ $symbol$branch ]($style)";
      };

      git_status = {
        style = "fg:#FFFFFF bg:#6F7CFF";

        format = "[$all_status$ahead_behind ]($style)";
      };

      time = {
        disabled = false;

        time_format = "%H:%M";

        style = "fg:#FFFFFF bg:#28B8D5";

        format = "[](fg:#6F7CFF bg:#28B8D5)[ ♥ $time ]($style)[](fg:#28B8D5)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        success_symbol = "[❯](bold #E56AA6) ";
        error_symbol = "[❯](bold #FF5C8A) ";
      };
    };
  };
}
