function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '$'
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_green}+"
ZSH_THEME_GIT_PROMPT_CLEAN=""


ZSH_THEME_COLOR_USER="magenta"
ZSH_THEME_COLOR_AT="black"
ZSH_THEME_COLOR_HOST="cyan"
ZSH_THEME_COLOR_COLON="black"
ZSH_THEME_COLOR_PWD="green"
ZSH_THEME_COLOR_BRACKETS="yellow"
ZSH_THEME_COLOR_PROMPT_CHAR="white"

# change user/host colors if ssh'd
test -n "$SSH_CONNECTION" && ZSH_THEME_COLOR_USER="red"

PROMPT='%{$fg_bold[$ZSH_THEME_COLOR_BRACKETS]%}[%{$fg_bold[$ZSH_THEME_COLOR_USER]%}%n%{$fg_bold[$ZSH_THEME_COLOR_AT]%}@%{$fg_bold[$ZSH_THEME_COLOR_HOST]%}%m%{$fg_bold[$ZSH_THEME_COLOR_COLON]%}:%{$fg_bold[$ZSH_THEME_COLOR_PWD]%}$(collapse_pwd)%{$fg_bold[$ZSH_THEME_COLOR_BRACKETS]%}]%{$fg_bold[$ZSH_THEME_COLOR_PROMPT_CHAR]%}$(prompt_char)%{$reset_color%} '

RPROMPT='$(git_prompt_info) %{$fg[blue]%}%*%{$reset_color%}'

