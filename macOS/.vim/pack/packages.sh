#!/usr/bin/env bash
# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}
# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}
(
set_group config
package https://github.com/bling/vim-airline.git &
package https://github.com/godlygeek/tabular.git &
package https://github.com/henrik/vim-indexed-search.git &
package https://github.com/jiangmiao/auto-pairs.git &
package https://github.com/mbbill/undotree.git &
package https://github.com/mhinz/vim-signify.git &
package https://github.com/scrooloose/nerdcommenter.git &
package https://github.com/scrooloose/syntastic.git &
package https://github.com/tpope/vim-fugitive.git &
package https://github.com/tpope/vim-sensible.git &
package https://github.com/tpope/vim-surround.git &
package https://github.com/tpope/vim-vinegar.git &
package https://github.com/yggdroot/indentLine.git &
package https://github.com/thiagoalessio/rainbow_levels.vim.git &
package https://github.com/rhysd/vim-gfm-syntax &
wait
) &
(
set_group code
package https://github.com/fatih/vim-go.git &
package https://github.com/mzlogin/vim-markdown-toc.git &
package https://github.com/rodjek/vim-puppet.git &
package https://github.com/vim-ruby/vim-ruby.git &
wait
) &
(
set_group themes
package https://github.com/miconda/lucariox.vim.git &
wait
) &
wait

