local cmp_kinds = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = "  ",
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = "  ",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
  Copilot = "  ",
}

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          local types = require("luasnip.util.types")
          local luasnip = require("luasnip")

          require("luasnip.loaders.from_vscode").lazy_load()

          luasnip.setup({
            history = true,
            delete_check_events = "TextChanged",
            ext_opts = {
              [types.insertNode] = {
                unvisited = {
                  virt_text = { { "|", "Conceal" } },
                  virt_text_pos = "inline",
                },
              },
            },
          })

          local react = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
          for _, lang in ipairs(react) do
            luasnip.add_snippets(lang, {
              luasnip.snippet("clog", {
                luasnip.text_node("console.log("),
                luasnip.insert_node(1),
                luasnip.text_node(")"),
              }),
            })
          end
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    version = false,
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      vim.keymap.set("i", "<S-Tab>", '<cmd>lua require("luasnip").jump(1)<CR>', { silent = true })
      vim.keymap.set("i", "<S-S-Tab>", '<cmd>lua require("luasnip").jump(-1)<CR>', { silent = true })

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind] .. vim_item.kind
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
