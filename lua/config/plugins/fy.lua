return {
  gh.."asters1/vim-fy",
  keys = { "fy","v","V" },
  config = function()
    vim.cmd([[
    " 需要设置hosts--->108.177.97.100 translate.googleapis.com
    " let g:translator_tool='fy'
    let g:translator_tool='bash'
    let g:translator_command=1
    let g:translator_file='translator.sh'
    nmap <silent> fy <Plug>TranslateW
    vmap <silent> fy <Plug>TranslateWV
    let g:translator_default_engines = [
    \ 'google']
    ]])
  end
}
