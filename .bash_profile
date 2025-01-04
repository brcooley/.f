# This should take care of things that we don't want updated for every new shell
# e.g. PATH and PS[1,2]
# NOTE: Do not set TERM in this file, espeically if you're using screen/tmux.

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

# Update PS1/2
if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi

# Finally, source our specific customizations
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

