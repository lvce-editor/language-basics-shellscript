if [ -n "$ABC" ]; then
	ABC="$(which -a 'abc' | grep /abc/)"
	if [ -n "$ABC" ]; then
		"$ABC" "$@"
		exit $?
	fi
fi