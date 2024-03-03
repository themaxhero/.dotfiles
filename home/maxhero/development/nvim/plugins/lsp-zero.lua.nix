{ pkgs, ... }:
''
  lua <<EOF
  local lsp = require("lsp-zero")

  lsp.preset("recommended")

  local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
  lsp_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false


  lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definitions() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    require("cmp_nvim_lsp").default_capabilities(lsp_capabilities)
  end)

  local lspconfig = require('lspconfig')

  lsp.default_setup()

  -- Lua LSP
  local lua_opts = lsp.nvim_lua_ls()
  lua_opts.cmd = {"${pkgs.luajitPackages.lua-lsp}/bin/lua-lsp"}
  lspconfig.lua_ls.setup(lua_opts)

  -- EFM LSP to enable credo

  lspconfig.efm.setup({
    capabilities = lsp_capabilities,
    on_attach = lsp.on_attach,
    cmd = {"${pkgs.efm-langserver}/bin/efm-langserver"},
    filetypes = {"elixir"},
  })

  -- Elixir LSP
  lspconfig.elixirls.setup({
    on_attach = lsp.on_attach,
    capabilities = lsp_capabilities,
    cmd = {"elixir-ls"},
    dialyzerEnabled = false,
    envVariables = {
      ["ELS_INSTALL_PREFIX"]="${pkgs.elixir-ls}/bin",
      ["ASDF_DIR"] = "${pkgs.asdf-vm}/bin",
    },
  })

  -- Node/Front
  lspconfig.html.setup({
    on_attach = lsp.on_attach,
    capabilities = lsp_capabilities,
    filetypes = { "html", "heex", "jsx" },
  })

  local cmp = require('cmp')
  local cmp_select = {behavior = cmp.SelectBehavior.Select}

  -- Helper Functions
  -- See: https://elixirforum.com/t/neovim-elixir-setup-configuration-from-scratch-guide/46310
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'vsnip'},
      {name = 'nvim_lua'},
      {name = 'luasnip', keyword_length = 2},
      {name = 'buffer', keyword_length = 3},
    },
    formatting = lsp.cmp_format(),
    snippet = {
       expand = function(args)
        -- setting up snippet engine
        -- this is for vsnip, if you're using other
        -- snippet engine, please refer to the `nvim-cmp` guide
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<C-Space>"] = cmp.mapping(function() cmp.complete() end),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
  })

  vim.diagnostic.config({virtual_text = true})
  EOF
''
