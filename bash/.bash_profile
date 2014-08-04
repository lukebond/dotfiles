alias ls='ls -FG'
alias listening='lsof -Pan -iTCP -sTCP:LISTEN'
alias git-log-graph='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias uuid="python -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)' | pbcopy && pbpaste && echo"

# Git branch in prompt.
parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[90m\]\u@\h \[\033[33m\]\$PWD\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\n$ "

export PATH=/Users/lukebond/bin:$PATH
