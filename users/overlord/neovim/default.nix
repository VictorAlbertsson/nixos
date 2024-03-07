{ nix-colors, config, pkgs, ... }:
let
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./extra-config.lua;
    extraPackages = with pkgs; [
      ripgrep
      fzf
      gopls
      unstable.htmx-lsp
      clang
      tailwindcss-language-server
    ];
    plugins = with pkgs.vimPlugins; [
    { 
      plugin = nix-colors-lib.vimThemeFromScheme { scheme = config.colorscheme; };
      config = "colorscheme nix-${config.colorscheme.slug}";
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = builtins.readFile ./nvim-web-devicons.lua;
    }
    { 
      plugin = telescope-nvim;
      type = "lua";
      config = builtins.readFile ./telescope-nvim.lua;
    }
    { 
      plugin = which-key-nvim;
      type = "lua";
      config = builtins.readFile ./which-key-nvim.lua;
    }
    {
      plugin = trouble-nvim;
      type = "lua";
      config = builtins.readFile ./trouble-nvim.lua;
    }
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = builtins.readFile ./nvim-lspconfig.lua;
    }
    { 
      plugin =
#nvim-treesitter.withAllGrammars
      (nvim-treesitter.withPlugins
       (treesitter-plugin: with treesitter-plugin; [
        # Scripting Languages
        nix
        vim
        lua
        bash
        # Programming Languages
        c
        go
        rust
        javascript
        # Markup Languages
        css
        scss
        html
        markdown
        markdown_inline
        # Data Formats
        sql
        json
        query
        jsdoc
        vimdoc
        luadoc
       ]));
      type = "lua";
      config = builtins.readFile ./nvim-treesitter.lua;
    }
    ];
  };
}
