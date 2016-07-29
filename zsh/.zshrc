# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _match _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/fox/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch notify
unsetopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install

#The following lines were added by you

#Setting up colored prompt
autoload -U promptinit
promptinit
autoload - U colors && colors

#Prompt
if [[ "$EUID" != "0" ]]
then
	USER_LEVEL="%F{cyan}"
else
	USER_LEVEL="%F{red}"
fi

PROMPT=${USER_LEVEL}[%F{white}%~${USER_LEVEL}]'── ─ '%f


#Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
export EDITOR=/usr/bin/nvim

#Colored MAN pages
if [ "$OSTYPE[0,7]" = "solaris" ]
then
	if [ ! -x ${HOME}/bin/nroff ]
	then
		mkdir -p ${HOME}/bin
		cat > ${HOME}/bin/nroff <<EOF
#!/bin/sh
if [ -n "\$_NROFF_U" -a "\$1,\$2,\$3" = "-u0,-Tlp,-man" ]; then
	shift
	exec /usr/bin/nroff -u\${_NROFF_U} "\$@"
fi
#-- Some other invocation of nroff
exec /usr/bin/nroff "\$@"
EOF
	chmod +x ${HOME}/bin/nroff
	fi
fi

man() {
      env \
      LESS_TERMCAP_mb=$(printf "\e[1;31m") \
      LESS_TERMCAP_md=$(printf "\e[1;31m") \
	  LESS_TERMCAP_me=$(printf "\e[0m") \
	  LESS_TERMCAP_se=$(printf "\e[0m") \
	  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	  LESS_TERMCAP_ue=$(printf "\e[0m") \
	  LESS_TERMCAP_us=$(printf "\e[1;32m") \
	  PAGER=/usr/bin/less \
	  _NROFF_U=1 \
	  PATH=${HOME}/bin:${PATH} \
	  			   man "$@"
}


#Colored output through environemetn variables (LESS)
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

#Increased ls colored output
eval $(dircolors -b)

#Aliases
. ~/.zalias
#Remove ctrl- sequences

#Base16 colours
#BASE16_SHELL="$HOME/.colors/base16/base16-ocean.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
