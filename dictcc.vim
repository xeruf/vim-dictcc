" --------------------------------
" Add to the path
" --------------------------------
python3 import sys
python3 import vim
python3 sys.path.append(vim.eval('expand("<sfile>:h")'))


" --------------------------------
"  Function(s)
" --------------------------------
function! DictTranslate(word)
python3 << endOfPython

from dictcc import DictQuery

def create_new_buffer(contents):
    vim.command('rightbelow split dictcc')
    vim.command('normal! ggdG')
    vim.command('setlocal filetype=txt')
    vim.command('call append(0, {0})'.format(contents))
    vim.command('setlocal readonly')
    vim.command('setlocal buftype=nowrite')
    vim.command('normal! gg')

create_new_buffer(DictQuery(vim.eval("a:word")).as_lines())

endOfPython
endfunction


function! DictTranslateWordUnderCursor()
  let word = expand("<cword>")
  :call DictTranslate(word)
endfunction


" --------------------------------
"  Expose our commands to the user
" --------------------------------
command! DictCur call DictTranslateWordUnderCursor()
command! -nargs=1 Dict call DictTranslate(<f-args>)
