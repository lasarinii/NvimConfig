require("lasarinii.remap")
require("lasarinii.config")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("lasarinii.plugins")

vim.cmd.colorscheme(require("lasarinii.plugins.colorscheme").name)

if vim.fn.executable('opam') then
  local opamshare = vim.fn.substitute(vim.fn.system('opam var share'), '\n$', '', '')
  if vim.fn.isdirectory(opamshare .. "/merlin/vim") then
    vim.fn.execute("set rtp+=" .. opamshare .. "/merlin/vim")
  end
end

print("hello from me")
