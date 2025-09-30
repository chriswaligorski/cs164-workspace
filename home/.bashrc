# Set prompt
export PS1="\[\033[01;35m\]\u\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\] $ "

# Set default editor
export EDITOR='vim'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
