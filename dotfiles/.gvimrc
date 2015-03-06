" gvim specific
"

if has("win32") || has("win16")

  " Copy on mouse-select
  :noremap <LeftRelease> "+y<LeftRelease>

  " disable bell
  set vb t_vb=

endif
