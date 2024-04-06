{ ... }@attrs:
pkgs:
let
  fullattrs = attrs // { inherit pkgs; };
in
{
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  defaultEditor = true;
  extraPackages = with pkgs; [
    libgcc
    gcc13
    luajitPackages.lua-lsp
    luajitPackages.luarocks
    elixir-ls
    xclip
  ];
  extraLuaConfig = builtins.readFile ./init.lua;
  plugins = with pkgs.vimPlugins; [
    {
      plugin = vim-monokai;
      config = "colorscheme monokai";
    }
    {
      plugin = telescope-nvim;
      config = ":luafile ${./plugins/telescope.lua}";
    }
    {
      plugin = nvim-treesitter.withAllGrammars;
      config = ":luafile ${./plugins/treesitter.lua}";
    }
    {
      plugin = lsp-zero-nvim;
      config = import ./plugins/lsp-zero.lua.nix fullattrs;
    }
    nvim-treesitter-context
    nvim-treesitter-refactor
    undotree
    nvim-lspconfig
    nvim-cmp
    cmp-buffer
    cmp-path
    cmp_luasnip
    cmp-nvim-lsp
    cmp-nvim-lua
    luasnip
    friendly-snippets
    vim-vsnip
    cmp-vsnip
  ];
}

