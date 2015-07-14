" Vim highlighting for PyCuda
" -----------------------------
"
" (C) Andreas Kloeckner 2011, MIT license
"
" Uses parts of mako.vim by Armin Ronacher.
"
" Installation:
" Just drop this file into ~/.vim/syntax/pyopencuda.vim
"
" Then do
" :set filetype=pyopencuda
" and use
" """//cuda// ...code..."""
" for Cuda code included in your Python file.
"
" You may also include a line
" vim: filetype=pyopencl.python
" at the end of your file to set the file type automatically.
"
" Optional: Install opencuda.vim from
" http://www.vim.org/scripts/script.php?script_id=3157

runtime! syntax/python.vim

unlet b:current_syntax
try
  syntax include @cudaCode syntax/cuda.vim
catch
  syntax include @cudaCode syntax/c.vim
endtry

unlet b:current_syntax
syn include @pythonTop syntax/python.vim

" {{{ mako

syn region cudamakoLine start="^\s*%" skip="\\$" end="$"
syn region cudamakoVariable start=#\${# end=#}# contains=@pythonTop
syn region cudamakoBlock start=#<%!# end=#%># keepend contains=@pythonTop

syn match cudamakoAttributeKey containedin=cudamakoTag contained "[a-zA-Z_][a-zA-Z0-9_]*="
syn region cudamakoAttributeValue containedin=cudamakoTag contained start=/"/ skip=/\\"/ end=/"/
syn region cudamakoAttributeValue containedin=cudamakoTag contained start=/'/ skip=/\\'/ end=/'/

syn region cudamakoTag start="</\?%\(def\|call\|page\|include\|namespace\|inherit\|self:[_[:alnum:]]\+\)\>" end="/\?>"

" The C highlighter's paren error detection screws up highlighting of
" Mako variables in C parens--turn it off.

syn clear cParen
syn clear cParenError
if !exists("c_no_bracket_error")
  syn clear cBracket
endif

syn cluster cudamakoCode contains=cudamakoLine,cudamakoVariable,cudamakoBlock,cudamakoTag

hi link cudamakoLine Preproc
hi link cudamakoVariable Preproc
hi link cudamakoBlock Preproc
hi link cudamakoTag Define
hi link cudamakoAttributeKey String
hi link cudamakoAttributeValue String

" }}}

syn region pythonCudaString
      \ start=+[uU]\=\z('''\|"""\)//CUDA\(:[a-zA-Z_0-9]\+\)\?//+ end="\z1" keepend
      \ contains=@cudaCode,@cudamakoCode

syn region pythonCudaRawString
      \ start=+[uU]\=[rR]\z('''\|"""\)//CUDA\(:[a-zA-Z_0-9]\+\)\?//+ end="\z1" keepend
      \ contains=@cudaCode,@cudamakoCode

" Uncomment if you still want the code highlighted as a string.
" hi link pythonCudaString String
" hi link pythonCudaRawString String

syntax sync fromstart

let b:current_syntax = "pycuda"

" vim: foldmethod=marker
