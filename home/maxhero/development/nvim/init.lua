vim.api.nvim_set_option("clipboard", "unnamed")
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
