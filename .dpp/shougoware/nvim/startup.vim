if g:dpp#_state_version !=# 3| throw "State version error" | endif
let [g:dpp#_plugins,g:dpp#ftplugin,g:dpp#_options,g:dpp#_check_files,g:dpp#_multiple_hooks] = g:dpp#_state
let g:dpp#_config_path = '/home/raizawa/.config/darkpowered/dpp.ts'
let &runtimepath = '$HOME/.dpp/shougoware/dpp.vim,/home/raizawa/.config/darkpowered,/home/raizawa/.dpp/shougoware/nvim/.dpp,/usr/share/nvim/runtime,/usr/lib/nvim,/usr/share/vim/vimfiles,$HOME/.dpp/shougoware/dpp-ext-toml,$HOME/.dpp/shougoware/dpp-protocol-git,$HOME/.dpp/shougoware/dpp-ext-lazy,/home/raizawa/.dpp/shougoware/nvim/.dpp/after'
filetype off
filetype plugin indent off
augroup dpp-ext-lazy
  autocmd!
  autocmd FuncUndefined *
       \ call dpp#ext#lazy#_on_func('<afile>'->expand())
 autocmd BufRead *? call dpp#ext#lazy#_on_default_event('BufRead')
 autocmd BufNew,BufNewFile *? call dpp#ext#lazy#_on_default_event('BufNew')
 autocmd VimEnter *? call dpp#ext#lazy#_on_default_event('VimEnter')
 autocmd FileType *? call dpp#ext#lazy#_on_default_event('FileType')
 autocmd CmdUndefined * call dpp#ext#lazy#_on_pre_cmd('<afile>'->expand())
augroup END
if has('nvim')
let g:dpp#ext#_on_lua_plugins = {}
let g:dpp#ext#_called_lua = {}
lua <<END
table.insert(package.loaders, 1, (function()
  return function(mod_name)
    mod_root = string.match(mod_name, '^[^./]+')
    if vim.g['dpp#ext#_on_lua_plugins'][mod_root] then
      vim.fn['dpp#ext#lazy#_on_lua'](mod_name, mod_root)
    end
    if package.loaded[mod_name] ~= nil then
      local m = package.loaded[mod_name]
      return function()
        return m
      end
    end
    return nil
  end
end)())
END
endif
function! s:define_on_map() abort
endfunction
autocmd dpp-ext-lazy SafeState * ++once call s:define_on_map()
autocmd dpp-ext-lazy VimEnter * call dpp#ext#lazy#_on_event('VimEnter')