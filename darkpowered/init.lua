local dpp_src = "$HOME/.dpp/shougoware/dpp.vim"
-- プラグイン内のLuaモジュールを読み込むため、先にruntimepathに追加する必要があります。
vim.opt.runtimepath:prepend(dpp_src) 
local dpp = require("dpp")

local dpp_base = "~/.dpp/shougoware/"
local dpp_config = "~/.config/darkpawered/dpp.ts"

local denops_src = "$HOME/.dpp/vim-denops/denops.vim"

local ext_toml = "$HOME/.dpp/shougoware/dpp-ext-toml"
local ext_lazy = "$HOME/.dpp/shougoware/dpp-ext-lazy"
local ext_installer = "$HOME/.dpp/shougoware/dpp-ext-installer"
local ext_git = "$HOME/.dpp/shougoware/dpp-protocol-git"

vim.opt.runtimepath:append(ext_toml)
vim.opt.runtimepath:append(ext_git)
vim.opt.runtimepath:append(ext_lazy)
vim.opt.runtimepath:append(ext_installer)

-- denops shared serverの設定
-- vim.g.denops_server_addr = "127.0.0.1:34141"

-- denopsのデバッグフラグ
-- denopsプラグインの開発をしない場合は0(デフォルト)にしてください
-- vim.g["denops#debug"] = 1

if dpp.load_state(dpp_base) then
  vim.opt.runtimepath:prepend(denops_src)

  vim.api.nvim_create_autocmd("User", {
	  pattern = "DenopsReady",
  	callback = function ()
		vim.notify("vim load_state is failed")
  		dpp.make_state(dpp_base, dpp_config)
  	end
  })
end

-- これはなくても大丈夫です。
vim.api.nvim_create_autocmd("User", {
	pattern = "Dpp:makeStatePost",
	callback = function ()
		vim.notify("dpp make_state() is done")
	end
})
