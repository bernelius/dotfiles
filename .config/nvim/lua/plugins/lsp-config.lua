return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls", "ts_ls", "clangd", "html", "jinja_lsp", "cssls", "ruff", "pyright", "tailwindcss", "eslint" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

--    this particular lsp is useless, but this is the format for
--    configuring an lsp from outside mason.

--      if not configs.dts_lsp then
--        configs.dts_lsp = {
--          default_config = {
--            cmd = { "dts-lsp" },
--            filetypes = { "dts" },
--            root_dir = lspconfig.util.root_pattern(".git"),
--            single_file_support = true,
--          },
--        }
--      end
--
--      lspconfig.dts_lsp.setup({ capabilities = capabilities })
--      lspconfig.djlint.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.djlsp.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({ capabilities = capabilities })
      lspconfig.jdtls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
--      lspconfig.jinja_lsp.setup({
--        capabilities = capabilities,
--        lang = { "python" },
--        filetypes = { "html", "htmldjango" },
--      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore"
            }
          }
        }
      })
      lspconfig.ruff.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "c" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = "LSP: Disable hover capability from Ruff",
      })
    end,
  },
}
