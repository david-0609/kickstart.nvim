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
  require('presence'):setup {
    auto_update = true,
    neovim_image_text = 'The One Editor To Rule Them All',
    client_id = '793271441293967371',
    main_image = 'neovim',
    show_time = true,
    buttons = true,
    enable_line_number = true,
    log_level = nil,

    editing_text = 'Editing %s',
    file_explorer_text = 'Browsing %s',
    git_commit_text = 'Committing changes',
    plugin_manager_text = 'Managing plugins',
    reading_text = 'Reading %s',
    workspace_text = 'Working on %s',
    line_number_text = 'Line %s out of %s',
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
