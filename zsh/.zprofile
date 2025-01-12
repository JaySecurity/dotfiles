# Set Shell

export SHELL=/usr/bin/zsh

# Theme Settings

export QT_STYLE_OVERIDE=GTK+
export QT_QPA_PLATFORMTHEME=qt6ct

# Default Apps

export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/brave
export TERMINAL=/usr/bin/kitty


export GOPATH=/home/jason/go
export GOBIN=/home/jason/go/bin

export DESKTOP_SESSION=gnome


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

