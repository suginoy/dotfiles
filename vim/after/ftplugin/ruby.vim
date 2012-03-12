" rubyの構文チェック cf. http://d.hatena.ne.jp/idesaku/20120104/1325636604
function! s:ExecuteMake()
  if &filetype == 'ruby' && expand('%:t') !~? '^pry\d\{8}.\+\.rb'
    silent make! -c "%" | redraw!
  endif
endfunction

compiler ruby
augroup rbsytaxcheck
  autocmd! BufWritePost <buffer> call s:ExecuteMake()
augroup END