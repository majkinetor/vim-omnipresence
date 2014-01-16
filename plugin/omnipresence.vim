if exists('g:loaded_omnipresence') | finish | en
let s:save_cpo = &cpo | set cpo&vim

call omnipresence#ensure_installed()

let &cpo = s:save_cpo | unlet s:save_cpo
let g:loaded_omnipresence = 1
