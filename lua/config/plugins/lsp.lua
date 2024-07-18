return {
  {
    gh.."williamboman/mason.nvim",
    config = function()
        vim.keymap.set('n', '<leader>m',':Mason<CR>')
      -- require("configs.mason").config()
      require("mason").setup({
        ui = {
          -- Whether to automatically check for new versions when opening the :Mason window.
          check_outdated_packages_on_open = true,

          -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
          border = "none",

          icons = {
            -- The list icon to use for installed packages.
            --package_installed = "◍",
            -- The list icon to use for packages that are installing, or queued for installation.
            --package_pending = "◍",
            -- The list icon to use for packages that are not installed.
            --package_uninstalled = "◍",
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },

          keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "X",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
          },
        },

        -- The directory in which to install packages.
        --install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },

        pip = {
          -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
          -- and is not recommended.
          --
          -- Example: { "--proxy", "https://proxyserver" }
          install_args = {},
        },

        -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
        -- debugging issues with package installations.
        log_level = vim.log.levels.INFO,

        -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
        -- packages that are requested to be installed will be put in a queue.
        max_concurrent_installers = 4,

        github = {
          -- The template URL to use when downloading assets from GitHub.
          -- The placeholders are the following (in order):
          -- 1. The repository (e.g. "rust-lang/rust-analyzer")
          -- 2. The release version (e.g. "v0.3.0")
          -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
          --download_url_template = "https://github.com/%s/releases/download/%s/%s",
        },
      })
    end,
  },
  {
    gh.. "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
        -- This setting has no relation with the `automatic_installation` setting.
        ensure_installed = {
          -- "lua_ls",
          -- -- use rustup instead install this directly
          -- --"rust_analyzer",
          -- "clangd",
          -- -- "cmake",
          -- "cssls",
          -- "gopls",
          -- "html",
          -- "jsonls",
          -- "quick_lint_js",
          -- -- "texlab",
          -- -- "marksman",
          "pyright",
          -- --"r_language_server",
          -- -- "sqlls",
          -- "taplo",
          -- "vimls",
          -- "vuels",
          -- "yamlls",
        },
        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Servers are not automatically installed.
        --   - true: All servers set up via lspconfig are automatically installed.
        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
        automatic_installation = true,
      })
    end,
  },
  {
    gh.."neovim/nvim-lspconfig",
    config = function()
      -- require("configs.lspconfig").config()
      --------------------------------nvim-cmp------------------------
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- luasnip setup
      local luasnip = require("luasnip")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local types = require("cmp.types")
      local str = require("cmp.utils.str")
      local lspkind = require("lspkind")

      -- nvim-cmp setup
      local cmp = require("cmp")

      --   פּ ﯟ   some other good icons
      --local kind_icons = {
      --Text = "",
      --Method = "m",
      --Function = "",
      --Constructor = "",
      --Field = "",
      --Variable = "",
      --Class = "",
      --Interface = "",
      --Module = "",
      --Property = "",
      --Unit = "",
      --Value = "",
      --Enum = "",
      --Keyword = "",
      --Snippet = "",
      --Color = "",
      --File = "",
      --Reference = "",
      --Folder = "",
      --EnumMember = "",
      --Constant = "",
      --Struct = "",
      --Event = "",
      --Operator = "",
      --TypeParameter = "",
      --}

      local kind_icons = {
        -- Class = '🅒',
        Class = "∴",
        -- Color = '☀',
        -- Color = '⛭',
        Color = "🖌",
        -- Constant = 'π',
        Constant = "𝜋",
        Constructor = "⬡",
        -- Constructor = '⌬',
        -- Constructor = '⎔',
        -- Constructor = '⚙',
        -- Constructor = 'ᲃ',
        Enum = "",
        EnumMember = "",
        Event = "",
        -- Field = '→',
        -- Field = '∴',
        --Field = '🠶',
        Field = "",
        File = "",
        Folder = "",
        Function = "ƒ",
        -- Function = 'λ',
        Interface = "",
        --Keyword = '🗝',
        Keyword = "",
        Method = "𝘮",
        -- Method = 'λ',
        --Module = '📦',
        Module = "",
        Operator = "≠",
        -- Operator = '±',
        -- Property = '::',
        Property = "∷",
        -- Reference = '⌦',
        Reference = "⊷",
        -- Reference = '⊶',
        -- Reference = '⊸',
        -- Snippet = '',
        -- Snippet = '↲',
        -- Snippet = '♢',
        -- Snippet = '<>',
        Snippet = "{}",
        Struct = "",
        --Text = '#',
        -- Text = '♯',
        -- Text = 'ⅵ',
        -- Text = "¶",
        -- Text = "𝒯",
        Text = "𝓣",
        -- Text = "𐄗",
        TypeParameter = "×",
        Unit = "()",
        -- Value           =
        -- Variable = '𝛼',
        -- Variable = 'χ',
        Variable = "𝓧",
        -- Variable = '𝛸',
        -- Variable = 'α',
        -- Variable = '≔',
      }
      -- other symbols that might be useful for something: -- ⊕ † ፨ ᯾ ⁂ ∎ ∹ ☖ ⚐ 🕮 🗈 🗉 🗈 🗉 ⬠  ⬡  ⮺  ⮻ ⯐  ⯒ ⟡ ✐  ✎ ꒾꙳ ꥟ ⤙ ⤚ ⤛ ⤜

      local select_opts = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
          ["<Down>"] = cmp.mapping.select_next_item(select_opts),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-e>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- super tab GOOD! But I like tab to confirm
          --["<tab>"] = cmp.mapping(function(fallback)
          --if cmp.visible() then
          --cmp.select_next_item()
          --elseif luasnip.expand_or_jumpable() then
          --luasnip.expand_or_jump()
          --elseif has_words_before() then
          --cmp.complete()
          --else
          --fallback()
          --end
          --end, { "i", "s" }),

          --["<S-Tab>"] = cmp.mapping(function(fallback)
          --if cmp.visible() then
          --cmp.select_prev_item()
          --elseif luasnip.jumpable(-1) then
          --luasnip.jump(-1)
          --else
          --fallback()
          --end
          --end, { "i", "s" }),
          --}),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
              ""
              )
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        experimental = {
          ghost_text = false,
        },
        window = {
          --documentation = {
          --border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          --},
          completion = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          },
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "treesitter" },
          {
            name = "latex_symbols",
            option = {
              strategy = 0, -- mixed
            },
          },
          { name = "calc" },
          { name = "path" },
          { name = "nvim_lua" },
          { name = "spell" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
              -- omni = "[VimTex]",
              omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              spell = "[Spell]",
              latex_symbols = "[Symbols]",
              cmdline = "[CMD]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
          --fields = {
          --cmp.ItemField.Abbr,
          --cmp.ItemField.Kind,
          --cmp.ItemField.Menu,
          --},
          --format = lspkind.cmp_format({
          --mode = "symbol_text",
          --maxwidth = 60,
          --before = function(entry, vim_item)
          --vim_item.menu = ({
          --nvim_lsp = "ﲳ",
          --nvim_lua = "",
          --treesitter = "",
          --path = "ﱮ",
          --buffer = "﬘",
          --zsh = "",
          --luasnip = "",
          --spell = "",
          --})[entry.source.name]

          ---- Get the full snippet (and only keep first line)
          --local word = entry:get_insert_text()
          --if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
          --word = vim.lsp.util.parse_snippet(word)
          --end
          --word = str.oneline(word)
          --if
          --entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
          --and string.sub(vim_item.abbr, -1, -1) == "~"
          --then
          --word = word .. "~"
          --end

          --vim_item.abbr = word

          --return vim_item
          --end,
          --}),
        },
        --enable catppuccin integration
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      sign({ name = "DiagnosticSignError", text = "✘" })
      sign({ name = "DiagnosticSignWarn", text = "▲" })
      sign({ name = "DiagnosticSignHint", text = "⚑" })
      sign({ name = "DiagnosticSignInfo", text = "" })

      --Another suit of icon
      --sign({ name = "DiagnosticSignError", text = "" })
      --sign({ name = "DiagnosticSignWarn", text = "" })
      --sign({ name = "DiagnosticSignHint", text = "" })
      --sign({ name = "DiagnosticSignInfo", text = "" })

      vim.diagnostic.config({
        virtual_text = true,
        --virtual_text = false,
        severity_sort = true,
        signs = true,
        update_in_insert = false,
        underline = false,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      --------------------------------lspconfig-----------------------
      local lspconfig = require("lspconfig")
      local util = require("lspconfig/util")

      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "B", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>F", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
      end

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }

      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

      local servers = {
        "clangd",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "cmake",
        "cssls",
        "vuels",
        "dockerls",
        "gopls",
        "html",
        "jsonls",
        "sqlls",
        "yamlls",
        "quick_lint_js",
        "texlab",
      }

      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          flags = lsp_flags,
        })
      end
    end,
    dependencies = {
      {gh.. "hrsh7th/nvim-cmp" },     -- Autocompletion plugin
      {gh.. "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
      {gh.. "hrsh7th/cmp-buffer" },
      {gh.. "hrsh7th/cmp-path" },
      {gh.. "hrsh7th/cmp-cmdline" },
      {gh.. "hrsh7th/cmp-nvim-lua" },
      {gh.. "f3fora/cmp-spell" },
      {gh.. "hrsh7th/cmp-calc" },
      {gh.. "kdheepak/cmp-latex-symbols" },
      {gh.. "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
      {
        gh.."L3MON4D3/LuaSnip",
        config = function()
          -- require("configs.luasnip").config()
          local luasnip_loader = require("luasnip.loaders.from_vscode")
          luasnip_loader.lazy_load()
          luasnip_loader.lazy_load({ paths = { "~/.config/nvim/snippets/" } })
          --require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/snippets/"}})

          --local keymap = vim.api.nvim_set_keymap
          --local opts = { noremap = true, silent = true }
          --keymap("i", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
          --keymap("s", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
          --keymap("i", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
          --keymap("s", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

          local luasnip = require("luasnip")
          luasnip.config.setup({
            region_check_events = "CursorHold,InsertLeave,InsertEnter",
            delete_check_events = "TextChanged,InsertEnter",
          })
        end,
        {
          -- dependencies = {
          { gh.."rafamadriz/friendly-snippets" },
        },
      }, -- Snippets plugin
      { gh.."ray-x/cmp-treesitter" },
      { gh.."onsails/lspkind.nvim" },
    },
  },
  {
    gh.."ray-x/lsp_signature.nvim",
    config = function()
      cfg = {
        debug = false,                                            -- set to true to enable debug logging
        log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
        -- default is  ~/.cache/nvim/lsp_signature.log
        verbose = false,                                          -- show debug line number
        bind = true,                                              -- This is mandatory, otherwise border config won't get registered.
        -- If you want to hook lspsaga or other signature handler, pls set to false
        doc_lines = 10,                                           -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
        -- set to 0 if you DO NOT want any API comments be shown
        -- This setting only take effect in insert mode, it does not affect signature help in normal
        -- mode, 10 by default

        max_height = 12,                     -- max height of signature floating_window
        max_width = 80,                      -- max_width of signature floating_window
        noice = false,                       -- set to true if you using noice to render markdown
        wrap = true,                         -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
        floating_window = true,              -- show hint in a floating window, set to false for virtual text only mode
        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        -- will set to true when fully tested, set to false will use whichever side has more space
        -- this setting will be helpful if you do not want the PUM and floating win overlap

        floating_window_off_x = 1, -- adjust float windows x position.
        -- can be either a number or function
        floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
        -- can be either number or function, see examples

        close_timeout = 4000, -- close floating window after ms when laster parameter is entered
        fix_pos = false,    -- set to true, the floating window will not auto-close until finish all parameters
        hint_enable = true, -- virtual hint enable
        --hint_prefix = "🐼 ",                      -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
        --hint_prefix = "🐧 ",
        --hint_prefix = "🦔 ",
        hint_prefix = "🦫 ",
        hint_scheme = "String",
        hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
        handler_opts = {
          border = "rounded",                       -- double, rounded, single, shadow, none, or a table of borders
        },
        always_trigger = false,                     -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
        auto_close_after = nil,                     -- autoclose signature float win after x sec, disabled if nil.
        extra_trigger_chars = {},                   -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
        zindex = 200,                               -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
        padding = "",                               -- character to pad on left and right of signature can be ' ', or '|'  etc
        transparency = nil,                         -- disabled by default, allow floating win transparent value 1~100
        shadow_blend = 36,                          -- if you using shadow as border use this set the opacity
        shadow_guibg = "Black",                     -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
        timer_interval = 200,                       -- default timer check interval set to lower value if you want to reduce latency
        toggle_key = nil,                           -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        select_signature_key = nil,                 -- cycle to next signature, e.g. '<M-n>' function overloading
        move_cursor_key = nil,                      -- imap, use nvim_set_current_win to move cursor between current win and floating
      }

      -- recommended:
      require("lsp_signature").setup(cfg) -- no need to specify bufnr if you don't use toggle_key
    end,
  },
}
