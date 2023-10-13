-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


--plugins
lvim.plugins = {
  --everforest
  { 'sainnhe/everforest' },
  { 'mfussenegger/nvim-dap' }
  --tokyonight
  --{'folke/tokyonight.nvim'}
};

--settings

--autoformat
--lvim.format_on_save = true

--colorscheme
lvim.colorscheme = "everforest"

--mapping
--compile and run
lvim.keys.normal_mode['<C-A-n>'] = ':cd ~/build | :!rm a.out <cr> | :w <cr> | :silent !g++ -g % <cr> | :!./a.out <cr>'
--set breakpoint
--left buffer
lvim.keys.normal_mode['<C-Left>'] = ':bprev <cr>'
--right buffer
lvim.keys.normal_mode['<C-Right>'] = ':bnext <cr>'

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<C-b>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<C-c>', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<C-t>', function() require('dapui').toggle() end)
vim.keymap.set('n', '<A-BS>', function() require('dap').disconnect() end)


--[[
vim.cmd[[
  map <C-A-n> : w <cr>
  map <C-A-n> : silent !g++ % <cr>
  map <C-A-n> : !./a.out <cr>
  map <C-A-n> : silent !rm a.out <cr>
]]



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
      program = "~/build/a.out",
      cwd = "${workspaceFolder}",
      arg = {},
    },
  }
end
