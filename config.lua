lvim.plugins = {
  --everforest
  -- { 'sainnhe/everforest' },
  --nvim-dap
  { 'mfussenegger/nvim-dap' },
  --lsp_signature
  { 'ray-x/lsp_signature.nvim' },
  --silicon(for taking snapshots of code)
  -- { 'krivahtoo/silicon.nvim'}
  --tokyonight
  {'folke/tokyonight.nvim'},

  --gruvbox
  -- {'morhetz/gruvbox'},

  --smooth scrolling
  {'karb94/neoscroll.nvim'}
};

--settings
--autoformat
-- lvim.format_on_save = true

--tab width
vim.opt.tabstop = 4
vim.opt.clipboard="unnamed,unnamedplus"

--reloads the buffer when it is updated externally
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
--colorscheme
lvim.colorscheme = "tokyonight-night"
-- lvim.colorscheme = "tokyonight-moon"
-- lvim.colorscheme = "gruvbox"

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
--debug configurations
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<C-b>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<C-c>', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<C-A-t>', function() require('dapui').toggle() end)
vim.keymap.set('n', '<A-BS>', function() require('dap').disconnect() end)

--toggle floating (function)signature


-- configure nvim-dap
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "/usr/bin/codelldb",
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
      program = function()
        return vim.fn.input('Path to executable: ')
      end,
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

require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})
