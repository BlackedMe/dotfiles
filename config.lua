-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

lvim.plugins = {
  -- gotham
  { 'whatyouhide/vim-gotham' },
  --tokyonight
  { 'folke/tokyonight.nvim' },
  --tokyodark
  { 'tiagovla/tokyodark.nvim' },
  --everforest
  { 'sainnhe/everforest' },
  --gruvbox
  { 'morhetz/gruvbox' },
  --neofusion
  { 'diegoulloao/neofusion.nvim' },
  --nvim-dap
  { 'mfussenegger/nvim-dap' },
  --lsp_signature
  { 'ray-x/lsp_signature.nvim' },
  --smooth scrolling
  { 'karb94/neoscroll.nvim' },
  --surround
  { 'tpope/vim-surround' },
  --vimtex
  { 'lervag/vimtex',
    lazy = false,
    tag = "v2.15",
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end
  },
  --arduino
  -- { 'stevearc/vim-arduino',
  --   lazy = false,
  -- },
  -- { 'sudar/vim-arduino-syntax'},
  -- splitjoin (too expensive and useless)
  -- { 'AndrewRadev/splitjoin.vim'}
  -- silicon(for taking snapshots of code)
  -- { 'krivahtoo/silicon.nvim'}
};

lvim.builtin.alpha.dashboard.section.header.val = {
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[  ██████   █████                   █████   █████  ███                  ]],
  [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
  [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
  [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
  [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
  [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
  [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
  [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
  [[                                                                       ]],
  [[                     λ done is better than perfect λ                   ]],
}

lvim.builtin.alpha.dashboard.section.footer.val = require 'alpha.fortune' ()

-- settings
-- autoformat
-- lvim.format_on_save = true

-- tab width
vim.opt.tabstop = 4
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }
-- reloads the buffer when it is updated externally
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- lvim.colorscheme = "gotham"
-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "tokyodark"
-- lvim.colorscheme = "everforest"
-- lvim.colorscheme = "gruvbox"
-- lvim.colorscheme = "neofusion"
-- mapping

-- compile and run
lvim.keys.normal_mode['<C-A-n>'] = ':!g++ -g % -o %:r <cr> | :!%:r <cr>'

-- compile and run (stdin and stdout from file)
lvim.keys.normal_mode['<C-A-m>'] = ':!g++ -g % -o %:r <cr> | :!%:r < ./%:h/input.txt > ./%:h/output.txt <cr>'

-- compile file
lvim.keys.normal_mode['<C-A-b>'] = ':!g++ -g % -o %:r <cr>'

-- left buffer
lvim.keys.normal_mode['<C-Left>'] = ':bprev <cr>'
-- right buffer
lvim.keys.normal_mode['<C-Right>'] = ':bnext <cr>'
lvim.keys.normal_mode['<C-F>'] = ':lua vim.lsp.buf.code_action() <cr>'
-- debug configurations
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<A-b>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<A-c>', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<C-A-t>', function() require('dapui').toggle() end)
vim.keymap.set('n', '<A-BS>', function() require('dap').disconnect() end)

-- toggle floating (function)signature


-- configure nvim-dap
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode-14",
    name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      console = "integratedTerminal",
      program = function()
        return vim.fn.input('Path to executable: ')
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      arg = {},
    },
  }
end


-- configure lsp_signature
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
  mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
    '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil,       -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

-- configure telescope
lvim.builtin.telescope.defaults.file_ignore_patterns = { "build", "node_modules", "%.cmake", "%.png", "%.svg" }

require('lspconfig').clangd.setup({
  cmd = { "clangd",
          "--header-insertion=never"},
})

vim.keymap.del("t", "<c-j>")
vim.keymap.del("t", "<c-k>")
