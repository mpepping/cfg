" gvim specific
"

if has("win32") || has("win16")

  " Copy on mouse-select
  :noremap <LeftRelease> "+y<LeftRelease>

endif
