return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd",
        "prettier",
        "stylua",
      },
    })
  end
}
