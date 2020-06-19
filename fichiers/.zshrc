# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000
setopt autocd nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sebastien/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Fix management of keys Home, End and Suppr.
bindkey  "\eO1~"  beginning-of-line
bindkey  "\eO4~"  end-of-line
bindkey  "\eO3~"  delete-char
bindkey  "^[[1~"  beginning-of-line
bindkey  "^[[4~"  end-of-line
bindkey  "^[[3~"  delete-char

PROMPT='%F{blue}%~%f %(!.#.$) '

# From https://unix.stackexchange.com/questions/97843/how-can-i-search-history-with-text-already-entered-at-the-prompt-in-zsh/97844
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\eOA' history-beginning-search-backward-end
bindkey '\eOB' history-beginning-search-forward-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# To compile with openssl-1.0 instead of openssl-1.1
#export PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig
#export CFLAGS=" -I/usr/include/openssl-1.0"
#export LDFLAGS=" -L/usr/lib/openssl-1.0 -lssl"

export VISUAL=gvim
export ARDUINO_USER_LIBS=~/Arduino/libraries

# From perl' local::lib
PATH="/home/sebastien/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/sebastien/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/sebastien/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/sebastien/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/sebastien/perl5"; export PERL_MM_OPT;

PATH=$PATH:/home/sebastien/bin

source ~/.aliases

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

