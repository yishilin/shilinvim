" NOTE: You must, of course, install the Dash app:
" Dash – Snippet Manager, Documentation Browser
" via http://kapeli.com/

if exists("g:loaded_Dash") || &cp
  finish
endif 

let g:loaded_Dash = "v1"

""========================================
"" Configuration
""---------------------------

""file_extension => dash_scope
if !exists("g:dash_scope_map")
  let g:dash_scope_map = {
    \ 'rb\|haml\|erb':  'ror',
    \ 'css':  'css',
    \}
endif


"" MAP
vmap <silent> tt :call Dash_Visual()<cr>
nmap <silent> tt :call Dash_Word()<cr>
command! -nargs=* -complete=file Dash call Dash_cmd(<q-args>)

""========================================


func! Dash_cmd(content) 
  let content = a:content
  call Dash(content, 1) 
endfun


function! s:GetVisualSelection()
  let save_a = @a
  silent normal! gv"ay
  let res = @a
  let @a = save_a
  return res
endfunction


func! Dash_Word() 
  let word = expand("<cword>")
  if "" == word 
    return
  endif
  call Dash(word, 0)
endfun


func! Dash_Visual() 
  let content = s:GetVisualSelection()
  call Dash(content, 0)
endfun


function! s:Dash_scope() 
  let extension = expand("%:e") "ruby|vim|css
  let scope = ""

  for pattern in keys(g:dash_scope_map)
    if extension =~ pattern
      let scope = g:dash_scope_map[pattern] . ":"
      break
    endif
  endfor
  return scope
endfunc

func! Dash(str, skip_current_ft) 
  let content = a:str
  if "" == content
    return
  endif

  if a:skip_current_ft == 1
    silent execute "!open dash://" . content
  else
    silent execute "!open dash://" . s:Dash_scope() . content 
  endif
  exec "redraw!"
endfun
