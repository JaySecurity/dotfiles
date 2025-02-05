# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/.local/share:$HOME/.config/scripts:$HOME/go/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jason/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh-custom"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

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


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
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
