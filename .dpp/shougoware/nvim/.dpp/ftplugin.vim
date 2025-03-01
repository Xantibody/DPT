if exists('g:did_load_ftplugin')
  finish
endif
let g:did_load_ftplugin = 1

augroup filetypeplugin
  autocmd!
  autocmd FileType * call s:ftplugin()
augroup END

function! s:ftplugin()
  if 'b:undo_ftplugin'->exists()
    silent! execute b:undo_ftplugin
    unlet! b:undo_ftplugin b:did_ftplugin
  endif

  let filetype = '<amatch>'->expand()
  if filetype !=# ''
    if &cpoptions =~# 'S' && 'b:did_ftplugin'->exists()
      unlet b:did_ftplugin
    endif
    for ft in filetype->split('\.')
      execute 'runtime!'
      \ 'ftplugin/' .. ft .. '.vim'
      \ 'ftplugin/' .. ft .. '_*.vim'
      \ 'ftplugin/' .. ft .. '/*.vim'
      if has('nvim')
        silent! execute 'runtime!'
        \ 'ftplugin/' .. ft .. '.lua'
        \ 'ftplugin/' .. ft .. '_*.lua'
        \ 'ftplugin/' .. ft .. '/*.lua'
      endif
    endfor
  endif
  call s:after_ftplugin()
endfunction

function! s:after_ftplugin()
endfunction