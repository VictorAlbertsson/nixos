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
    plugins = with pkgs.vimPlugins; [
    { 
      plugin = nix-colors-lib.vimThemeFromScheme { scheme = config.colorscheme; };
      config = "colorscheme nix-${config.colorscheme.slug}";
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
