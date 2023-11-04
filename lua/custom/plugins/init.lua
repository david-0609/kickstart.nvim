return {

  {
    'bennypowers/splitjoin.nvim',
    lazy = true,
    keys = {
      {
        'gj',
        function()
          require('splitjoin').join()
        end,
        desc = 'Join the object under cursor',
      },
      {
        'g,',
        function()
          require('splitjoin').split()
        end,
        desc = 'Split the object under cursor',
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    opts = {},
  },
  {
    'romgrk/barbar.nvim',
    lazy = true,
    event = 'BufRead',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {

      auto_hide = 1,

      exclude_ft = { 'alpha' },
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    cmd = 'NvimTreeToggle',
    config = function()
      require('nvim-tree').setup {
        sort_by = "case_sensitive",
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
    end
  },
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    keys = {
      {
        "<c-t>",
        function()
          require('toggleterm').toggle()
        end
      }
    },
    version = '*',
    config = function()
      require('toggleterm').setup {
        border = 'single',
        size = 10,
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }
    end,
  },
  {
    'rmagatti/goto-preview',
    lazy = true,
    keys = {
      {
        'gpd',
        function()
          require('goto-preview').goto_preview_definition()
        end,
      },
      {
        'gpi',
        function()
          require('goto-preview').goto_preview_implementation()
        end,
      },
      {
        'gpt',
        function()
          require('goto-preview').goto_preview_type_definition()
        end,
      },
      {
        'gpr',
        function()
          require('goto-preview').goto_preview_references()
        end,
      },
      {
        'gP',
        function()
          require('goto-preview').close_all_win()
        end,
      }
    },
    config = function()
      require('goto-preview').setup {
        default_mappings = false,
      }
    end,
  },
  {
    'folke/zen-mode.nvim',
    lazy = true,
    cmd = 'ZenMode',
    config = function()
      require('zen-mode').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  -- {
  --   'dinhhuy258/git.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('git').setup()
  --   end,
  -- },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    cmd = "Gitsigns",
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    'samodostal/image.nvim',
    lazy = true,
    event = 'BufRead',
    ft = {
      'jpg',
      'png',
      'jpeg',
      'webp',
      'bmp',
    },
    config = function()
      require('image').setup {
        render = {
          min_padding = 5,
          show_label = true,
          use_dither = true,
          foreground_color = true,
          background_color = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      }
    end,
  },
  { 'm00qek/baleia.nvim' },
  {
    'lcheylus/overlength.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      require('overlength').setup()
    end,
  },
  {
    'phaazon/mind.nvim',
    lazy = true,
    requires = {
      'nvim-lua/plenary.nvim',
    },
    branch = 'v2.2',
    config = function()
      require('mind').setup()
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    lazy = true,
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = {
      'markdown',
    },
  },
  --["levouh/tint"] = {
  --  config = function()
  --    require("tint").setup()
  --  end
  --}
  {
    'Djancyp/better-comments.nvim',
    lazy = true,
    event = 'BufRead',
    run = function()
      require('better-comment').Setup()
    end,
  },
  -- ["vigoux/notifier.nvim"] = {
  --   config = function()
  --     require("notifier").setup()
  --   end
  -- },
  --
  {
    'gaoDean/autolist.nvim',
    lazy = true,
    ft = {
      'markdown',
      'text',
      'tex',
      'plaintex',
      'norg',
    },
    config = function()
      require('autolist').setup()

      vim.keymap.set('i', '<tab>', '<cmd>AutolistTab<cr>')
      vim.keymap.set('i', '<s-tab>', '<cmd>AutolistShiftTab<cr>')
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set('i', '<cr>', '<cr><cmd>AutolistNewBullet<cr>')
      vim.keymap.set('n', 'o', 'o<cmd>AutolistNewBullet<cr>')
      vim.keymap.set('n', 'O', 'O<cmd>AutolistNewBulletBefore<cr>')
      vim.keymap.set('n', '<CR>', '<cmd>AutolistToggleCheckbox<cr><CR>')
      vim.keymap.set('n', '<C-r>', '<cmd>AutolistRecalculate<cr>')

      -- cycle list types with dot-repeat
      vim.keymap.set('n', '<leader>cn', require('autolist').cycle_next_dr, { expr = true })
      vim.keymap.set('n', '<leader>cp', require('autolist').cycle_prev_dr, { expr = true })

      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set('n', '>>', '>><cmd>AutolistRecalculate<cr>')
      vim.keymap.set('n', '<<', '<<<cmd>AutolistRecalculate<cr>')
      -- vim.keymap.set('n', 'dd', 'dd<cmd>AutolistRecalculate<cr>')
      -- vim.keymap.set('v', 'd', 'd<cmd>AutolistRecalculate<cr>')
    end,
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    lazy = true,
    event = 'BufEnter',
    config = function()
      -- require('mini.cursorword').setup()
      require('mini.move').setup()
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    lazy = true,
    cmd = 'GitConflict',
    config = function()
      require('git-conflict').setup()
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    lazy = true,
    event = 'BufRead',
    config = function()
      require('colorizer').setup {
        filetypes = { '*' },
        user_default_options = {
          RGB = true,          -- #RGB hex codes
          RRGGBB = true,       -- #RRGGBB hex codes
          names = true,        -- "Name" codes like Blue or blue
          RRGGBBAA = false,    -- #RRGGBBAA hex codes
          AARRGGBB = false,    -- 0xAARRGGBB hex codes
          rgb_fn = false,      -- CSS rgb() and rgba() functions
          hsl_fn = false,      -- CSS hsl() and hsla() functions
          css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = 'background', -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true,                                -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { 'css' } }, -- Enable sass colors
          virtualtext = '■',
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }
    end,
  },
  {
    'gen740/SmoothCursor.nvim',
    lazy = true,
    event = 'CursorMoved',
    config = function()
      require('smoothcursor').setup({})
    end,
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    event = 'BufRead',
  },
  {
    'simrat39/rust-tools.nvim',
    lazy = true,
    after = 'nvim-lspconfig',
    ft = { "rust", "toml" },
    config = function()
      require("rust-tools").setup {

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
            vim.keymap.set('n', '<leader>ca', rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      }
    end
  },
  {
    'm-demare/hlargs.nvim',
    lazy = true,
    -- config = function ()
    --   require("hlargs").setup()
    -- end
  },
  {
    'lervag/vimtex',
    lazy = true,
    ft = {
      'tex',
      'plaintex',
      'texinfo',
    }
  },
  {
    'gorbit99/codewindow.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      local codewindow = require 'codewindow'
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
  { 'sitiom/nvim-numbertoggle', lazy = true, event = 'BufRead' },
  {
    'gnikdroy/projections.nvim',
    lazy = true,
    branch = 'pre_release',
  },
  {
    'nullchilly/fsread.nvim',
    lazy = true,
    cmd = "FSToggle"
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup { --[[ your config ]]
      }
    end,
  },
  {
    'andweeb/presence.nvim',
    lazy = true,
  },
  {
    'asiryk/auto-hlsearch.nvim',
    lazy = true,
    event = "CmdlineEnter",
    config = function()
      require('auto-hlsearch').setup()
    end,
  },
  {
    'andrewferrier/wrapping.nvim',
    lazy = true,
    cmd = 'ToggleWrapMode',
    config = function()
      require('wrapping').setup()
    end,
  },
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    lazy = true,
    ft = 'html',
    config = function()
      require('tailwindcss-colorizer-cmp').setup()
    end,
  },
  -- ["hrsh7th/nvim-cmp"] = {
  --   config = function()
  --   require("cmp").config.formatting = {
  --     format = require("tailwindcss-colorizer-cmp").formatter
  --   }
  -- end
  -- }
  {
    'antonk52/markdowny.nvim',
    lazy = true,
    ft = 'markdown',
    config = function()
      require('markdowny').setup()
    end,
  },
  {
    'giusgad/pets.nvim',
    lazy = true,
    dependencies = { 'MunifTanjim/nui.nvim', 'giusgad/hologram.nvim' },
    config = function()
      require('pets').setup()
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    event = "InsertEnter",
    version = '1.*',
    build = 'make install_jsregexp',
    requires = { 'rafamadriz/friendly-snippets', 'molleweide/LuaSnip-snippets.nvim' },
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'BufRead',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'goolord/alpha-nvim',
    lazy = false,
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'custom.plugins.configs.alpha'
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'saecki/crates.nvim',
    lazy = true,
    ft = 'toml',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup()
    end,
  },
  {
    'wintermute-cell/gitignore.nvim',
    lazy = true,
    cmd = 'Gitignore',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'SmiteshP/nvim-navbuddy',
    lazy = true,
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
    },
    event = 'BufRead',
    config = function()
      require('nvim-navbuddy').setup {
        lsp = {
          auto_attach = true,
        },
      }
    end,
  },
  {
    'fedepujol/move.nvim',
    lazy = true,
    event = 'BufRead',
  },
  -- {
  --   'HiPhish/nvim-ts-rainbow2',
  --   lazy = true,
  --   event = 'BufRead',
  --   dependencies = 'nvim-treesitter',
  --   config = function()
  --     require('nvim-treesitter.configs').setup {
  --       rainbow = {
  --         enable = true,
  --         -- list of languages you want to disable the plugin for
  --         disable = { 'jsx', 'cpp' },
  --         -- Which query to use for finding delimiters
  --         query = 'rainbow-parens',
  --         -- Highlight the entire buffer all at once
  --         strategy = require('ts-rainbow').strategy.global,
  --       },
  --     }
  --   end,
  -- },
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = true,
  },
  {
    'AckslD/muren.nvim',
    event = 'BufRead',
    config = true,
  },
  {
    'Exafunction/codeium.vim',
    lazy = true,
    event = "InsertEnter",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  {
    'tzachar/highlight-undo.nvim',
    event = 'BufRead',
    config = function()
      require('highlight-undo').setup()
    end,
  },
  { 'onsails/lspkind.nvim' },
  { 'justinhj/battery.nvim' },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
      lsp = {
        progress = {
          enabled = false
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        presets = {
          command_palette = true
        }
      },
      -- you can enable a preset for easier configuration
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    "Dhanus3133/LeetBuddy.nvim",
    lazy = true,
    cmd = {
      "LBQuestions",
      "LBQuestion",
      "LBReset",
      "LBTest",
      "LBSubmit",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("leetbuddy").setup({
        domain = "com",
        langauge = "py"
      })
    end,
    keys = {
      { "<leader>lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
      { "<leader>ll", "<cmd>LBQuestion<cr>",  desc = "View Question" },
      { "<leader>lr", "<cmd>LBReset<cr>",     desc = "Reset Code" },
      { "<leader>lt", "<cmd>LBTest<cr>",      desc = "Run Code" },
      { "<leader>ls", "<cmd>LBSubmit<cr>",    desc = "Submit Code" },
    },
  },
  {
    'mrjones2014/legendary.nvim',
    lazy = true,
    cmd = 'Legendary',
    version = 'v2.1.0',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    -- priority = 10000,
    -- lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
    config = function()
      require('legendary').setup({
        which_key = {
          auto_register = true,
        },
        lazy_nvim = {
          -- Automatically register keymaps that are defined on lazy.nvim plugin specs
          -- using the `keys = {}` property.
          auto_register = true,
        },
        extensions = {
          nvim_tree = true,
          smart_splits = {},
        }
      })
    end
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = "Git"
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = {
      "TroubleToggle",
      "Trouble",
      "TroubleClose",
      "TroubleRefresh",
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'justinmk/vim-sneak',
    lazy = false,
  },
  {
    'rareitems/hl_match_area.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      require('hl_match_area').setup({})
    end,
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "CursorMoved",
    config = function()
      require('illuminate').configure()
    end
  },
  {
    'eandrju/cellular-automaton.nvim',
    lazy = true,
    cmd = "CellularAutomaton",
  },
  {
    'ThePrimeagen/vim-be-good',
    lazy = true,
    cmd = "VimBeGood"
  }
  -- {
  --   'nvimdev/dashboard-nvim',
  --   lazy = false,
  --   requires = { 'nvim-tree/nvim-web-devicons' },
  --   -- priority = 10000,
  --   -- event = 'VimEnter',
  --   config = function()
  --     require('dashboard').setup {
  --       -- config
  --       config = {
  --         week_header = {
  --           enable = true,
  --         }
  --       },
  --       hide = {
  --         tabline = true
  --       }
  --     }
  --   end,
  --   dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  -- }
}
