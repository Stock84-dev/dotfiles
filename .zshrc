# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/stock/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="nicoulaj"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(wakatime)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

autoload -U compinit promptinit zsh-mime-setup
compinit
promptinit
zsh-mime-setup

# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# Case insensitive globbing
setopt NO_CASE_GLOB

# command completion
autoload -U compinit
compinit
# auto-completion with keyboard
zstyle ':completion:*' menu select
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# generate descriptions with magic
zstyle ':completion:*' auto-description 'specify: %d'
# autocompletion of command line switches for alias
setopt completealiases

DIRSTACKSIZE=20 # set limit for allowed dirs in pushd hist
# 1st option always pushd after dir change
# 2nd option don't print dirs list after popd
# 3rd option swaps meaning of popd +3 & popd -3
# last option says to ignore dup dirs in dirs list
setopt autopushd pushdsilent pushdminus pushdignoredups

# History stuff
HISTFILE=/home/stock/.zhistory
SAVEHIST=1000
HISTSIZE=1000
# Prevent from putting duplicate lines in the history
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
# Write after each command
setopt INC_APPEND_HISTORY

# rehash automatically so new files in $PATH are found for auto-completion
zstyle ':completion:*' rehash true


# Disable "flow control" which locks terminal when pressing ctrl-s
stty -ixon


# --- Theme ---
# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END='>'
PROMPT_ROOT_END='>>>'
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Define prompts.
#PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
#PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
#RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
PROMPT='%B%F{071}%2~%f%F{071}>%f%b '
# 
# 
#
#
#
#
#
#
#
#
#
# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
# autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
export EDITOR=vim
export VISUAL=vim
export PATH="/home/stock/.config/coc/extensions/coc-rust-analyzer-data:$PATH"
# using vim sa manpager https://github.com/gotbletu/shownotes/blob/master/vim_neovim_manpager.md
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
# setting how many characters should vim display as manpager
export MANWIDTH=94
export ALPHAVANTAGE_API_KEY="LIEOIJJRT1NL3HX9"
export RUST_BACKTRACE=full
export RUST_LIB_BACKTRACE=1
export RUST_LOG=trace
# export RUSTC_WRAPPER=sccache
alias vim="nvim"
alias v="nvim"
alias p="cd /home/stock/ssd/projects/the_matrix/the_matrix && nvim . && cd -"
alias r="ranger"
alias b="upower -i /org/freedesktop/UPower/devices/battery_CMB1"
alias :q="exit"
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias ca="cargo add"
alias cc="cargo check"
alias ce="cargo expand"
alias cw="cargo watch"
alias cbr="cargo build --release"
alias crr="cargo run --release"
alias w="curl wttr.in/Zagreb"
alias gcd="git clone --depth=1"
source ~/data/linux/scripts/gtm-plugin.sh
c ()
{
	curl rate.sx/$1
}

# must evalueate last so that it picks up any configuration changes
eval "$(mcfly init zsh)"

export PATH=/home/stock/.tiup/bin:$PATH

reboot () {
	printf "Are you sure you want to reboot [y/n]"
	read RESPONSE
	if [ "$RESPONSE" = "y" ]
	then
		/usr/bin/reboot
	else
		echo "response not y"
	fi
}

shutdown () {
	if [ "$1" = "now" ] 
	then
		printf "Are you sure you want to shutdown [y/n]"
		read RESPONSE
		if [ "$RESPONSE" = "y" ]
		then
			/usr/bin/shutdown
		else
			echo "response not y"
		fi
	else
		/usr/bin/shutdown "$@"
	fi
}
