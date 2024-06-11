local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

if vim.loader then
  vim.loader.enable()
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("vim-options")
require("lazy").setup("plugins", {
  --remove notification for each change made to the config files, very annoying by default
  change_detection = {
    notify = false,
  },
})
