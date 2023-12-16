require("nvim-treesitter.configs").setup {
  -- ensure_installed = { "help", "javascript", "typescript", "elixir", "erlang", "c", "rust", "lua"},
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  },
}
