function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '$'
}

PROMPT='%{$fg[yellow]%}[%{$fg[magenta]%}%n%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg[black]%}:%{$fg_bold[green]%}$(collapse_pwd)%{$fg[yellow]%}]%{$reset_color%}$(prompt_char) '

RPROMPT='$(git_prompt_info) %{$fg[blue]%}%*%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
