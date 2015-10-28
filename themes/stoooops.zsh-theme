# turn on command substitution in the prompt
setopt prompt_subst

# Make sure colors load properly when this file is sourced on its own
source $ZSH/lib/spectrum.zsh
autoload -U colors && colors

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo "$"
}

# copied and modified from lib/git.zsh:git_prompt_info()
function my_git_prompt_branch() {                                                    
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then             
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || return            
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi 
}   

# copied and modified from lib/git.zsh:git_prompt_status()
function my_git_prompt_status() {
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""

  # ahead/behind/diverged
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    NUM_AHEAD=$( command echo "$INDEX" | grep '^## .*ahead' | cut -d "[" -f2 | cut -d "]" -f1 | cut -d " " -f2)
    for i in {1..$NUM_AHEAD}
    do
      STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
    done
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    NUM_BEHIND=$( command echo "$INDEX" | grep '^## .*behind' | cut -d "[" -f2 | cut -d "]" -f1 | cut -d " " -f2)
    for i in {1..$NUM_AHEAD}
    do
      STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
    done
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  
  # untracked
  if $(echo "$INDEX" | grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  
  # modified
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  
  # dirty
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ "$(command git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    else
      GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    fi
    if [[ -n $GIT_STATUS ]]; then
      STATUS="$ZSH_THEME_GIT_PROMPT_DIRTY$STATUS"
    else
      STATUS="$ZSH_THEME_GIT_PROMPT_CLEAN$STATUS"
    fi
  else
    STATUS="$ZSH_THEME_GIT_PROMPT_CLEAN$STATUS"
  fi

  # added
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  
  # renamed
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  
  # deleted
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  
  # stashed
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
  fi
  
  # unmerged
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi

  echo $STATUS
}



ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[166]%}*"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}\u2191"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[yellow]%}\u2193"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[yellow]%}\u2197"  
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

#setopt PROMPT_SUBST

PROMPT='%{$fg_no_bold[$ZSH_THEME_COLOR_BRACKETS]%}[%{$fg_no_bold[$ZSH_THEME_COLOR_USER]%}%n%{$fg_no_bold[$ZSH_THEME_COLOR_AT]%}@%{$fg_no_bold[$ZSH_THEME_COLOR_HOST]%}%M%{$fg_no_bold[$ZSH_THEME_COLOR_COLON]%}:%{$fg_no_bold[$ZSH_THEME_COLOR_PWD]%}$(collapse_pwd)%{$fg_no_bold[$ZSH_THEME_COLOR_BRACKETS]%}]%{$fg_no_bold[$ZSH_THEME_COLOR_PROMPT_CHAR]%}$(prompt_char)%{$reset_color%} '

if [ "$STOOOOPS_OH_MY_ZSH_THEME_DISABLE_RPROMPT" != true ]; then
  RPROMPT='$(my_git_prompt_branch)$(my_git_prompt_status)%{$reset_color%}'
fi
