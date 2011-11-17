" NOTE: You must, of course, install the ack script
"       in your path.
" On Debian / Ubuntu:
"   sudo apt-get install ack-grep
" On your vimrc:
"   let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"
" With MacPorts:
"   sudo port install p5-app-ack

" Location of the ack utility
if !exists("g:ackprg")
	let g:ackprg="ack -H --nocolor --nogroup --column"
endif

function! s:Ack(cmd, args)
    redraw
    echo "Searching ..."

    " If no pattern is provided, search for the word under the cursor
    if empty(a:args)
        let l:grepargs = expand("<cword>")
    else
        let l:grepargs = a:args
    end

    " Format, used to manage column jump
    if a:cmd =~# '-g$'
        let g:ackformat="%f"
    else
        let g:ackformat="%f:%l:%c:%m"
    end

    let grepprg_bak=&grepprg
    let grepformat_bak=&grepformat
    try
        let &grepprg=g:ackprg
        let &grepformat=g:ackformat
        silent execute a:cmd . " " . l:grepargs
    finally
        let &grepprg=grepprg_bak
        let &grepformat=grepformat_bak
    endtry

    if a:cmd =~# '^l'
        botright lopen
    else
        botright copen
    endif

    exec "nnoremap <silent> <buffer> q :ccl<CR>"
    exec "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
    exec "nnoremap <silent> <buffer> T <C-W><CR><C-W>TgT<C-W><C-W>"
    exec "nnoremap <silent> <buffer> o <CR>"
    exec "nnoremap <silent> <buffer> go <CR><C-W><C-W>"
    exec "nnoremap <silent> <buffer> v <C-W><C-W><C-W>v<C-L><C-W><C-J><CR>"
    exec "nnoremap <silent> <buffer> gv <C-W><C-W><C-W>v<C-L><C-W><C-J><CR><C-W><C-J>"

    " If highlighting is on, highlight the search keyword.
    if exists("g:ackhighlight")
        let @/=a:args
        set hlsearch
    end

    redraw!
endfunction

function! s:AckFromSearch(cmd, args)
    let search =  getreg('/')
    " translate vim regular expression to perl regular expression.
    let search = substitute(search,'\(\\<\|\\>\)','\\b','g')
    call s:Ack(a:cmd, '"' .  search .'" '. a:args)
endfunction

command! -bang -nargs=* -complete=file Ack call s:Ack('grep<bang>',<q-args>)
command! -bang -nargs=* -complete=file AckAdd call s:Ack('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AckFromSearch call s:AckFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAck call s:Ack('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAckAdd call s:Ack('lgrepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AckFile call s:Ack('grep<bang> -g', <q-args>)



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


func! Ack_Quickfix(str) 
  let content = a:str
  if "" == content
    return
  endif

  "" first, to clear all the marks.
  exec "Mark"
  "" then call mark.vim to mark it.
  exec "Mark " . content 

  " let g:project_root = "/local/yottaa/com.yottaa.dpu""
  if !exists("g:project_root")
    let g:project_root = ". "
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


