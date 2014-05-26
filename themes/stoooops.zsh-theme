function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '$'
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}↑"
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

PROMPT='%{$fg_no_bold[$ZSH_THEME_COLOR_BRACKETS]%}[%{$fg_no_bold[$ZSH_THEME_COLOR_USER]%}%n%{$fg_no_bold[$ZSH_THEME_COLOR_AT]%}@%{$fg_no_bold[$ZSH_THEME_COLOR_HOST]%}%M%{$fg_no_bold[$ZSH_THEME_COLOR_COLON]%}:%{$fg_no_bold[$ZSH_THEME_COLOR_PWD]%}$(collapse_pwd)%{$fg_no_bold[$ZSH_THEME_COLOR_BRACKETS]%}]%{$fg_no_bold[$ZSH_THEME_COLOR_PROMPT_CHAR]%}$(prompt_char)%{$reset_color%} '

RPROMPT='$(git_prompt_info)$(git_prompt_status)$(git_prompt_ahead) %{$fg[blue]%}%*%{$reset_color%}'

