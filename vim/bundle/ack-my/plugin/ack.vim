"" -------------------------------------
"" visual search mappings
"" to search the selected word
function! s:Search(arg)
    let @@ = a:arg
    norm! gvy
    let @/ = substitute(escape(@@, '\'), '\n', '\\n', 'g')
endfunction


function! s:GetVisualSelection()
  let save_a = @a
  silent normal! gv"ay
  let res = @a
  let @a = save_a
  return res
endfunction


"" add by yisl
"" vimgrep current word in current file
"" and show result in quickfix window
func! Ack_Word_Quickfix() 
  let word = expand("<cword>")
  if "" == word 
    return
  endif

  if 'windows' == g:platform
    let word_start= "\\b"
  else
    let word_start= "\\\\b"
  endif
  let content = word_start . word . word_start
  call Ack_Quickfix(content)

  "" first, to clear all the marks.
  exec "Mark"
  "" then call mark.vim to mark it.
  exec "Mark " . word 

  call s:Search(word)
endfun


"" add by yisl
"" ack selected(visual) in rails project
"" and show result in quickfix window
func! Ack_Visual_Quickfix() 
  let content = s:GetVisualSelection()
  call Ack_Quickfix(content)

  call s:Search(content)
endfun


func! Ack_cmd_Quickfix(content) 
  let content = a:content
  call Ack_Quickfix(content) 
  call s:Search(content)
endfun


function! CurDir()
   let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
   return curdir
endfunction

func! Ack_Quickfix(str) 
  let content = a:str
  if "" == content
    return
  endif

  "" first, to clear all the marks.
  exec "Mark"
  "" then call mark.vim to mark it.
  exec "Mark " . content 

  if !exists("g:project_root")
    let g:project_root = CurDir()
  endif
  let grepprg_bak=&grepprg
  exec "set grepprg=" . g:ackprg
  execute "silent! grep " . content . " " . g:project_root
  botright copen
  let &grepprg=grepprg_bak
  exec "redraw!"
endfun



"" add by yisl
vmap <silent> <F6> :call Ack_Visual_Quickfix()<cr>
nmap <silent> <F6> :call Ack_Word_Quickfix()<cr>
command! -nargs=* -complete=file Ackcmd call Ack_cmd_Quickfix(<q-args>)


