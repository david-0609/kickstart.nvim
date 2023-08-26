--

vim.cmd [[colorscheme tokyonight-night]]
require 'custom.mappings'
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require('nvim-tree').setup {
  sort_by = 'case_sensitive',
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
--
-- Define the function you want to run
function special_highlights()
  -- Do something here
  vim.cmd 'hi! link @keyword Keyword'
  vim.cmd 'hi! link @keyword.function Keyword'
  vim.cmd 'hi! link @keyword.return Keyword'
  -- vim.cmd('hi Type gui=italic')
  vim.cmd 'hi! link @Function Function'
  -- vim.cmd('hi @define gui=italic')
end
-- Define an autocmd that runs when a buffer is opened
vim.cmd 'autocmd BufRead * lua special_highlights()'

vim.cmd 'command! MindOpenMain lua lazy_load_mind()'
function lazy_load_mind()
  local mind = require 'mind'
  mind.setup()
  mind.open_main()
end

vim.cmd 'command! PresenceEnable lua lazy_load_presence()'
function lazy_load_presence()
  require('presence').setup {
    -- General options
    auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text = 'The One True Text Editor', -- Text displayed when hovered over the Neovim image
    main_image = 'neovim', -- Main image display (either "neovim" or "file")
    client_id = '793271441293967371', -- Use your own Discord application client id (not recommended)
    log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number = false, -- Displays the current line number instead of the current project
    blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons = true, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time = true, -- Show the timer

    -- Rich Presence text options
    editing_text = 'Editing %s', -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text = 'Browsing %s', -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text = 'Committing changes', -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = 'Managing plugins', -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text = 'Reading %s', -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text = 'Working on %s', -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text = 'Line %s out of %s', -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
  }
end
--
-- -- Define a function to run when the buffer is of a specific file type
-- function load_hlargs()
--   require("hlargs").setup()
--   require('hlargs').enable()
-- end
--
-- -- Use the autocmd command to run the function when the buffer is of a specific file type
-- vim.cmd([[autocmd FileType c,cpp,c_sharp,go,java,javascript,lua,julia,jsx,nix,php,python,r,ruby,rust,tsx,typescript,vim,zig lua load_hlargs()]])
--
function lazy_load_pets()
  require('pets').setup()
end

vim.cmd 'command! PetsEnable lua lazy_load_pets()'

require('mason-lspconfig').setup {
  ensure_installed = {
    -- lua stuff
    'lua_ls',

    -- web dev stuff
    'cssls',
    'html',
    'denols',
    'dockerls',
    'texlab',
    'ltex',
    'pyright',
    'marksman',
    'tailwindcss',
    'rust_analyzer',
    'zls',
  },
}

local projections_loaded = false
function lazy_load_projections()
  if not projections_loaded then
    require('projections').setup {
      workspaces = { -- Default workspaces to search for
        -- "~/dev",                               dev is a workspace. default patterns is used (specified below)
        { '~/Documents/dev', { '.git', 'Cargo.toml' } },
        { '~/.config', { '.git', 'init.lua', 'nvim' } },
        -- { "~/repos", {} },                     An empty pattern list indicates that all subfolders are considered projects
      },
    }

    -- Bind <leader>fp to Telescope projections
    require('telescope').load_extension 'projections'
    -- vim.keymap.set('n', '<leader>fp', function()
    --   vim.cmd 'Telescope projections'
    -- end)

    -- Autostore session on VimExit
    -- local Session = require 'projections.session'
    -- vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    --   callback = function()
    --     Session.store(vim.loop.cwd())
    --   end,
    -- })

    -- Switch to project if vim was started in a project dir
    -- local switcher = require 'projections.switcher'
    -- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    --   callback = function()
    --     if vim.fn.argc() == 0 then
    --       switcher.switch(vim.loop.cwd())
    --     end
    --   end,
    -- })

    projections_loaded = true

    vim.cmd 'Telescope projections'
  else
    vim.cmd 'Telescope projections'
  end
end
vim.cmd 'command! Projections lua lazy_load_projections()'

vim.keymap.set('n', '<leader>fp', '<cmd> Projections <cr>', { noremap = true, silent = true })

vim.keymap.set('i', '<CR>', function()
  -- run autolist-new-bullet after the <cr> of nvim-autopairs-cr
  -- timeout of 0ms delays enough for my computer but u might need to adjust
  local timeoutms = 0
  vim.loop.new_timer():start(
    timeoutms,
    0,
    vim.schedule_wrap(function()
      require('autolist').new_bullet()
    end)
  )

  return require('nvim-autopairs').autopairs_cr()
end, { expr = true, noremap = true })

local rt = require 'rust-tools'

rt.setup {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = { locationLinks = false },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },

  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
}

local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    commonlisp = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
  blacklist = { 'c', 'cpp' },
}

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

vim.g.codeium_disable_bindings = 1

local barbar_loaded = false
function lazy_load_barbar()
  -- Count number of open buffers
  local num_buffers = 0
  for _ in pairs(vim.api.nvim_list_bufs()) do
    num_buffers = num_buffers + 1
  end
  if not barbar_loaded then
    if num_buffers > 1 then
      require('barbar').setup()
      barbar_loaded = true
    end
  end
end

vim.cmd 'autocmd BufRead * lua lazy_load_barbar()'
