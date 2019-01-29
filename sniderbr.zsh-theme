function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

if [[ "$USER" != "$DEFAULT_USER" && "$USER" != "bsnider" && "$USER" != "sniderbr" || -n "$SSH_CLIENT" ]]; then
  local user='%{$fg[magenta]%}%n@%{$fg[magenta]%}%m%{$reset_color%} '
else
  local user=''
fi
local pwd='%{$fg[blue]%}$(get_pwd)%{$reset_color%}'
local return_code='%(?..%{$fg[red]%}%?%{$reset_color%})'
local git_branch='$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=":%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[magenta]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}±"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}‼"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}→"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?"

PROMPT="${user}${pwd}${git_branch} $ "
RPROMPT="${return_code}"

