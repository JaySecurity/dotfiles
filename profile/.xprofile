# Set Shell

export SHELL=/usr/bin/zsh
export DESKTOP_SESSION=gnome

# Theme Settings

export QT_STYLE_OVERIDE=GTK+
export QT_QPA_PLATFORMTHEME=qt6ct

# Default Apps

export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/brave
export TERMINAL=/usr/bin/kitty


export GOPATH=/home/jason/go
export GOBIN=/home/jason/go/bin

export OLLAMA_API_BASE=http://127.0.0.1:11434 
export AIDER_OLLAMA_API_KEY=""
export AIDER_MODEL="ollama_chat/llama3:8b"
export AIDER_EDITOR=nvim


if [ -z "$SSH_AUTH_SOCK" ]; then
    # Check for a currently running instance of the agent
    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
    fi
    eval `cat $HOME/.ssh/ssh-agent`
    ssh-add $HOME/.ssh/gitlab
    ssh-add $HOME/.ssh/github
fi

