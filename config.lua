-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


--plugins
lvim.plugins = {
  --everforest
  { 'sainnhe/everforest' },
  --nvim-dap
  { 'mfussenegger/nvim-dap' },
  --lsp_signature
  { 'ray-x/lsp_signature.nvim' },
  --silicon(for taking snapshots of code)
  -- { 'krivahtoo/silicon.nvim'}
  --tokyonight
  --{'folke/tokyonight.nvim'}
};

--settings
--autoformat
-- lvim.format_on_save = true

--tab width
vim.opt.tabstop = 4

--colorscheme
lvim.colorscheme = "everforest"

--mapping

--compile and run
lvim.keys.normal_mode['<C-A-n>'] = ':!g++ -g % -o %:r <cr> | :!%:r <cr>'

--compile and run (stdin and stdout from file)
lvim.keys.normal_mode['<C-A-m>'] = ':!g++ -g % -o %:r <cr> | :!%:r < ./%:h/input.txt > ./%:h/output.txt <cr>'

--save file
lvim.keys.normal_mode['<C-A-b>'] = ':w <cr>';

--left buffer
lvim.keys.normal_mode['<C-Left>'] = ':bprev <cr>'
--right buffer
lvim.keys.normal_mode['<C-Right>'] = ':bnext <cr>'
lvim.keys.normal_mode['<C-F>'] = ':lua vim.lsp.buf.code_action() <cr>'
lvim.keys.normal_mode["<C-q>"] = false

--debug configurations
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<C-b>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<C-c>', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<C-t>', function() require('dapui').toggle() end)
vim.keymap.set('n', '<A-BS>', function() require('dap').disconnect() end)

--toggle floating (function)signature


-- configure nvim-dap
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = "${fileDirname}/${fileBasenameNoExtension}",
      cwd = "${workspaceFolder}",
      arg = {},
    },
  }
end


--configure lsp_signature
require 'lsp_signature'.setup({
  on_attach = function()
    require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    })
  end,
}
)
