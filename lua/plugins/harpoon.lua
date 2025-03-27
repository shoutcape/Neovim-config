return {
	"ThePrimeagen/harpoon",
  lazy = true,
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		require("harpoon").setup({
      global_settings = {
        tabline = true,
        -- Enable saving marks when exiting neovim
        save_on_toggle = true,
        -- Enable saving marks on any change
        save_on_change = true,
        -- Set the mark file path
        mark_file = vim.fn.expand("~/.cache/nvim/harpoon.json"),
        -- Enter the filetypes that should not be marked
        excluded_filetypes = { "harpoon", "TelescopePrompt", "alpha" },
      }
    })

    vim.keymap.set("n", "<leader>h", function()
      local conf = require("telescope.config").values
      local files = {}
      for _, item in ipairs(harpoon:list().items) do
        table.insert(files, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = files,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end, { desc = "Open harpoon in Telescope" })

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)

		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<A-j>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<A-k>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<A-l>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "ò", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end
}
