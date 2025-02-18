# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/.local/share:$HOME/.config/scripts:$HOME/go/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jason/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh-custom"


# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


plugins=(docker git kubectl fnm direnv fzf ollama)

source $ZSH/oh-my-zsh.sh

# User configuration
eval "$(dircolors ~/.dir_colors)"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias evim='NVIM_APPNAME=evim nvim'
alias lsl="ls -la | more"
alias mongoC="mongo 192.168.2.2/ -u jason -p password --authenticationDatabase admin"
alias ganache="ganache-cli -m 'come input math question labor suit report funny unlock range conduct stadium'"
alias e='function f(){echo "$1";}; f'
alias ee='function f(){echo "$1"|base64;}; f'
alias ed='function f(){echo "$1"|base64 --decode;}; f'
alias node16='nvm use node 16'
alias node18='nvm use node 18'
alias node20='nvm use node 20'
alias scrcpy="~/.config/scripts/scrcpy2"
alias runaider="docker run -it --user $(id -u):$(id -g) --network host --volume $(pwd):/app -e OLLAMA_API_BASE=http://127.0.0.1:11434 paulgauthier/aider-full:latest"
# alias npm=pnpm
# alias npx='pnpm exec'


# source <(kubectl completion zsh)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# Automatically switch NVM version if an .nvmrc file exists in the directory
# cd() {
#     builtin cd "$@"
#     if [[ -f .nvmrc && -r .nvmrc ]]; then
#         nvm use
#     fi
# }

# pnpm
export PNPM_HOME="/home/jason/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
FNM_PATH="/home/jason/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="/home/jason/.local/share/fnm:$PATH"
    # eval "`fnm env`"
    # eval "$(fnm env --use-on-cd )"
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

export TIMEWARRIORDB=/home/jason/Nextcloud/timewarrior/data

eval $(thefuck --alias)
