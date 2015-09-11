#
# ~/.bashrc
# Customized bash configuration
#

# -- GENERAL SETTINGS -- ------------------------------
#

# -- Simpler prompt w/ name of current dir only
#
if [ `id -u` -eq 0 ]; then
	export PS1='\W # '
else
	export PS1='\W $ '
fi

# -- Aliases
#
alias ls='ls -FhN'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias top='top -o %CPU'

unalias grep
unalias egrep
unalias fgrep


# -- DEVELOPMENT SETTINGS -- ------------------------------
#

DEV=/home/projects
IMPORTS=/home/imports

if [ -a $DEV ]; then
	if ! [[ $PATH =~ $DEV/tools ]]; then
		export PATH=$DEV/tools:$PATH
	fi

	alias node='node --use_strict --harmony --expose_gc'
	export NODE_DISABLE_COLORS=1
	if ! [[ $NODE_PATH =~ nodejs ]]; then
		export NODE_PATH=$DEV/libs/nodejs:$IMPORTS/node_modules
	fi
fi



