# This should take care of things that we don't want updated for every new shell
# e.g. PATH and PS[1,2]

SSH_ENV="$HOME/.ssh/environment"

# First, we set the PATH to include our private bin and .local bin
if [ -d "${HOME}/bin" ] ; then
	PATH="${HOME}/bin:${PATH}"
fi

if [ -d "${HOME}/.local/bin" ]; then
	PATH="${HOME}/.local/bin:${PATH}"
fi

# Source the local bash_profile if it exists
if [ -f ~/.bash_profile_local ]; then
	source ~/.bash_profile_local
fi

# Starting ssh-agent if not already started, from http://mah.everybody.org/docs/ssh
function start_agent {
    # echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    # echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}
                              
# Source SSH settings, if applicable
                          
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    # ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Finally, source our specific customizations
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

