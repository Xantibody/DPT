local dppSrc = "~/.dpp/shougoware/dpp.vim"
local denopsSrc = "~/.dpp/vim-denops/denops.vim"
local denopsInstaller ="~/.dpp/shougoware/dpp-ext-installer"
local dppConfig ="~/.config/darkpowered/dpp.ts"

vim.opt.runtimepath:prepend(dppSrc)

local dpp = require("dpp")

local dppBase = "~/.dpp/cache"
if dpp.load_state(dppBase) then
  vim.opt.runtimepath:prepend(denopsSrc)
  vim.opt.runtimepath:prepend(denopsInstaller)

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function()
      vim.notify("dpp load_state() is failed")
      dpp.make_state(dppBase, dppConfig)
    end,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("dpp make_state() is done")
  end,
})

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
