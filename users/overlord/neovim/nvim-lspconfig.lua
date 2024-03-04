local DEFAULT_FQBN = "arduino:avr:nano"
local board_list = {
  ["/home/overlord/projects/arduino/foderautomat"] = "arduino:renesas_uno:unor4wifi",
}
local lspconfig = require('lspconfig')

lspconfig.gopls.setup({})
lspconfig.htmx.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.arduino_language_server.setup({
  on_new_config = function(config, root)
    local fqbn = board_list[root]
    if not fqbn then
      vim.notify(("Could not find which FQBN to use in %q. Defaulting to %q."):format(root_dir, DEFAULT_FQBN))
      fqbn = DEFAULT_FQBN
    end
    config.cmd = {
      "arduino-language-server",
      "-cli-config", "/home/overlord/.arduino15/arduino-cli.yaml",
      "-fqbn", fqbn
    }
  end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable Omnifunc completion <C-X><C-O>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- TODO: Add `which-key` annotations
    -- Buffer local mappings
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD',                  vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd',                  vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K',                   vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi',                  vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>',               vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa',          vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr',          vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>D',           vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn',          vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr',                  vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
