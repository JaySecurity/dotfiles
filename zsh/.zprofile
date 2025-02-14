# export QT_QPA_PLATFORMTHEME=qt6ct
# export QT_STYLE_OVERRIDE=GTK+
# export QT_DIR=$HOME/Qt
# export GTK2_RC_FILES=$HOME/.config/gtkrc-2.0
export GTK_THEME=Adwaita-dark

export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/brave
export TERMINAL=/usr/bin/kitty

export AWS_PROFILE=Dev-Under
export GOPATH=$HOME/go
export UNITY_PATH=$HOME/Unity/Hub
export HSA_OVERRIDE_GFX_VERSION="10.3.0"
export OLLAMA_API_BASE=http://127.0.0.1:11434
# export OLLAMA_DATA_DIR=/Storage/ollama/
export OLLAMA_MODELS=/Storage/ollama/models
export AIDER_MODEL=ollama_chat/deepseek-r1:14b
export OPENAI_API_KEY=""

export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/share:$HOME/.config/scripts:/usr/local/bin:$HOME/go/bin

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


export MM_SEED="come input math question labor suit report funny unlock range conduct stadium"
