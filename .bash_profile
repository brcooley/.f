# This should take care of things that we don't want updated for every new shell
# e.g. PATH and PS[1,2]

SSHAGENT="/usr/bin/ssh-agent"

# First, we set the PATH to include our private bin and .local bin
if [ -d "${HOME}/bin" ] ; then
	PATH="${HOME}/bin:${PATH}"
fi

if [ -d "${HOME}/.local/bin" ]; then
	PATH="${HOME}/.local/bin:${PATH}"
fi

# Start ssh-agent if it isn't already running
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
	eval `$SSHAGENT -s`
	trap "kill $SSH_AGENT_PID" 0
fi
ssh-add

# Finally, source our specific customizations
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

