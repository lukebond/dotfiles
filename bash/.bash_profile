alias ls='ls -FG'

# Git branch in prompt.
parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[90m\]\u@\h \[\033[33m\]\$PWD\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "

export PATH=/Users/lukebond/bin:$PATH
