" mygit: get the current git branch
"   Author:	shilin yishilin@gmail.com
"   Date:		Sep 23, 2011
"   Version: 1.0	

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_mygit") || &cp
 finish
endif
let g:loaded_mygit = "v1"
let s:keepcpo          = &cpo
set cpo&vim


if !exists('g:git_bin')
    let g:git_bin = 'git'
endif        

" Returns current git branch.
" Call inside 'statusline' or 'titlestring'.
function! GitBranch()
    let git_dir = <SID>GetGitDir()

    if strlen(git_dir) && filereadable(git_dir . '/HEAD')
        let lines = readfile(git_dir . '/HEAD')
        if !len(lines)
            return ''
        else
            return matchstr(lines[0], 'refs/heads/\zs.\+$')
        endif
    else
        return ''
    endif
endfunction


" Ensure b:git_dir exists.
function! s:GetGitDir()
    if !exists('b:git_dir')
        let b:git_dir = s:SystemGit('rev-parse --git-dir')
        if !v:shell_error
            let b:git_dir = fnamemodify(split(b:git_dir, "\n")[0], ':p') . '/'
        endif
    endif
    return b:git_dir
endfunction


function! s:SystemGit(args)
    " workardound for MacVim, on which shell does not inherit environment
    " variables
    if has('mac') && &shell =~ 'sh$'
        return system('EDITOR="" '. g:git_bin . ' ' . a:args)
    else
        return system(g:git_bin . ' ' . a:args)
    endif
endfunction
                           


" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
