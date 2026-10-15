{ pkgs, ... }:

let
  # Treesitter parsers we actually want.
  #
  # We install the parsers directly instead of installing the
  # full nvim-treesitter plugin. Neovim itself can use them.
  treesitterGrammars =
    with pkgs.vimPlugins.nvim-treesitter-parsers;
    [
      nix
      lua
      bash

      go
      gomod
      gosum

      python

      json
      toml
      yaml

      markdown
      markdown_inline
    ];

  # Highlighting queries paired with the parsers above.
  treesitterQueries =
    map (grammar: grammar.associatedQuery) treesitterGrammars;

in
{
  programs.neovim = {
    enable = true;

    # Neovim becomes $EDITOR for your user.
    defaultEditor = true;

    # `vim`, `vi`, etc. launch Neovim for Gunter.
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins =
      with pkgs.vimPlugins;
      [
        # Explorer, picker, icons, statusline, pairs...
        mini-nvim

        # Provides standard LSP server configurations.
        # It does NOT install the language servers themselves.
        nvim-lspconfig
      ]
      ++ treesitterGrammars
      ++ treesitterQueries;

    extraPackages = with pkgs; [
      # MiniPick project-wide searching.
      ripgrep

      # Nix language server.
      nil

      # Lua language server.
      lua-language-server
    ];

    # Main portable Neovim configuration.
    initLua =
      builtins.readFile ../config/nvim/init.lua;
  };

  # Additional Lua modules.
  xdg.configFile."nvim/lua/core" = {
    source = ../config/nvim/lua/core;
  };
}
