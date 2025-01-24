# Based on bira theme



() {

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%m%f' # no SSH
fi

return_code="%(?..%F{red}%? ↵%f)"
user_host="${PR_USER}%F{cyan}@${PR_HOST}"
current_dir="%B%F{blue}%~%f%b"
venv_prompt='$(virtualenv_prompt_info)' 
}

precmd(){
  update_git_branch;
if [[ ${#$(git_branch)} -gt 0 ]]; then
    PROMPT="╭─${user_host} ${venv_prompt} \$(ruby_prompt_info)
│ $(git_branch)
│ ${current_dir} 
╰─$PR_PROMPT "
else
    PROMPT="╭─${user_host} ${venv_prompt} \$(ruby_prompt_info)
│ ${current_dir} 
╰─$PR_PROMPT "
 fi
}


update_git_branch(){

 GIT_BRANCH=$(_omz_git_prompt_info)
}

git_branch(){
  echo "${GIT_BRANCH}"
}

# Custom function to format the virtualenv name
virtualenv_prompt_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Get the base name of the virtualenv
    local venv_name=$(basename "$VIRTUAL_ENV")
    # Trim the part after the last '-'
    local trimmed_venv_name=${venv_name%-*}
    echo "%F{red}($trimmed_venv_name)%f "
  fi
}

setopt prompt_subst

RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"
ZSH_THEME_VIRTUALENV_PREFIX="%F{red}("
ZSH_THEME_VIRTUALENV_SUFFIX=")%f "


