# This should take care of things that we don't want updated for every new shell
# e.g. PATH and PS[1,2]
#

# First, we set the PATH to include our private bin
if [ -d "${HOME}/bin" ] ; then
	PATH="${HOME}/bin:${PATH}"
fi


# Finally, source our specific customizations
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

