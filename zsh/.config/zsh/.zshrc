# zmodload zsh/zprof

# -------------------- settings --------------------
# neofetch
# figlet -c "WELCOME SAJID"
setopt autocd		
setopt interactive_comments
# disable ctrl-s to freeze terminal.
# stty stop undef		
autoload -Uz compinit; compinit

# autoload -Uz compinit
# for dump in $ZDOTDIR/.zcompdump(N.mh+24); do
#   compinit
#done
# compinit -C

source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
export BROWSER="google-chrome-stable"

# -------------------- plugins --------------------
# zinit plgins manager install
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# install zsh plugins
# zinit ice wait lucid
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
  zinit light starship/starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# -------------------- tab completion styling --------------------
_comp_options+=(globdots)		 # Include hidden files.
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# disable sort when completing `git checkout`.
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support.
zstyle ':completion:*:descriptions' format '[%d]'
# preview directories or file content when completing cat
zstyle ':fzf-tab:complete:batcat:*' fzf-preview '[[ -d "$realpath" ]] && eza -1a --icons=always --color=always --tree --level=2 --ignore-glob=".git|node_modules|.next" "$realpath" || batcat --color=always "$realpath"'
zstyle ':fzf-tab:complete:cat:*' fzf-preview '[[ -d "$realpath" ]] && eza -1a --icons=always --color=always --tree --level=2 --ignore-glob=".git|node_modules|.next" "$realpath" || batcat --color=always "$realpath"'
# preview sub directories with eza when completing cd or zoxide
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1a --icons=always --color=always --tree --level=2 --ignore-glob=".git|node_modules" $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1a --icons=always --color=always --tree --level=2 --ignore-glob=".git|node_modules" $realpath'
# preview sub directories with eza when completing vim
zstyle ':fzf-tab:complete:vim:*' fzf-preview '[[ -d "$realpath" ]] && eza -1a --icons=always --color=always --tree --level=2 --ignore-glob=".git|node_modules|.next" "$realpath" || batcat --color=always "$realpath"'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# fzf-tab height and width issue fix
zstyle ':fzf-tab:*' fzf-min-height '60'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:*' popup-min-size 20
# zmodload zsh/complist

# -------------------- history setup --------------------
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history
HISTDUP=erase
# if history file does not exists then create the file
[ ! -d $HISTFILE ] && mkdir -p "$(dirname $HISTFILE)"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# -------------------- keybindings --------------------
bindkey -e
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
# edit line in vim with ctrl-v.
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line
# bindkey -M vicmd '^[[P' vi-delete-char
# bindkey -M vicmd '^e' edit-command-line
# bindkey -M visual '^[[P' vi-delete

# -------------------- integraions --------------------
eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# -------------------- fzf config --------------------
show_file_or_dir_preview='[ -d {} ] && eza -1a --icons=always --color=always --tree --level=5 --ignore-glob=".git|node_modules|.next" {} | head -200 || batcat -n --color=always --line-range :500 {}'

export FZF_DEFAULT_COMMAND='fdfind --hidden --strip-cwd-prefix --exclude .git'
export FZF_DEFAULT_OPTS="--reverse --height 60% --border --prompt '  ' --preview '$show_file_or_dir_preview' --color=bg:#0a0f0f,prompt:cyan,pointer:cyan,marker:cyan,spinner:cyan"
# ctlr-t key options
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"
# alt-c key options for directory only
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type=d"
export FZF_ALT_C_OPTS='--preview "eza -1a --icons=always --color=always --tree --level=5 --ignore-glob=\".git|node_modules|.next\" {} | head -200"'
# export TMUX_TMPDIR=$XDG_RUNTIME_DIR

# -------------------- sesh config --------------------
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --border-label ' sesh ' --prompt '⚡  ')
    # session=$(sesh list -i | gum filter --limit 1 --placeholder 'Pick a sesh' --height 50 --prompt='⚡')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# -------------------- shortcut aliases --------------------
alias source-ls="lt /etc/apt/ --level=3"
alias hs="home-manager switch --flake ~/dotfiles/nix/home-manager#$USER --impure"
alias nix-bin="ls ~/.nix-profile/bin"
alias weather="curl -4 wttr.in/chattogram"
alias cd="z"
# # sudo not required for some system commands
# for command in mount umount sv pacman updatedb su shutdown poweroff reboot; do
#   alias $command="sudo $command"
# done
# unset command

# Start graphical server on user's current tty if not already running.
# [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

# wezterm
[ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"

# remove duplicate path
typeset -U PATH path

# zprof


# bun completions
[ -s "/home/sajid/.bun/_bun" ] && source "/home/sajid/.bun/_bun"
