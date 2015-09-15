#
# ~/.bashrc and /root/.bashrc
# Customized bash configuration for the current user and root
#


# -- PROMPT -- --------------------------------------------------

# simpler prompt w/ name of current dir only
if [ `id -u` -eq 0 ]; then
	export PS1='\W # '
else
	export PS1='\W $ '
fi


# -- ALIASES -- --------------------------------------------------

# no color
alias ls='ls -FhN'

# prompt, unless -n or -f specified
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# sorted by cpu load
alias top='top -o %CPU'

# no colors
unalias grep
unalias egrep
unalias fgrep


