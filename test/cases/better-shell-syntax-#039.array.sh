var1="Lorem ipsum dolor sit amet"
declare -A ASSOC_ARRAY
ASSOC_ARRAY=(
    [item1]=$var1
    [item2]=$'\033[1;94m'
    [item3]="lorem-ipsum"
    [item4]=100
    [item5]=$'\033[1;95m'
    [item6]=$'\033[1;93m'
    [item7]=$var1
)

#!/usr/bin/env bash

# https://wiki.manjaro.org/index.php/Snap
# https://packages.ubuntu.com/bionic/gnome/gnome-software-plugin-snap
# https://snapcraft.io/docs/installing-snap-on-opensuse
# https://software.opensuse.org/download/package?package=snapd&project=system:snappy
# https://en.opensuse.org/Snap <-- this is the correct info
# https://software.opensuse.org/download/package?package=snapd&project=system:snappy <-- this is not correct

# https://packages.debian.org/sid/amd64/snapd/filelist
# /usr/bin/snap
# /usr/bin/snapctl
# /usr/bin/ubuntu-core-launcher

function setup_util_snap() (
	source "$DOROTHY/sources/bash.bash"

	# checks
	if ! is-linux; then
		echo-style --notice="[$0] is only intended to be run on Linux systems, skipping." >/dev/stderr
		return 0
	fi

	# setup
	local options=(
		--name='snap'
		--cli='snap'
		"$@"
		APT='snapd' # UBUNTU
		AUR='snapd' # ARCH
		RPM='snapd' # FEDORA
		ZYPPER_REPO_ALIAS='snappy'
		ZYPPER_REPO="https://download.opensuse.org/repositories/system:snappy/$(get-opensuse-release 2>/dev/null || :)/"
		ZYPPER='snapd' # SUSE
	)
	local a options=(
		--name='snap'
		--cli='snap'
		"$@"
		APT='snapd' # UBUNTU
		AUR='snapd' # ARCH
		RPM='snapd' # FEDORA
		ZYPPER_REPO_ALIAS='snappy'
		ZYPPER_REPO="https://download.opensuse.org/repositories/system:snappy/$(get-opensuse-release 2>/dev/null || :)/"
		ZYPPER='snapd' # SUSE
	)
	setup-util "${options[@]}"

	# if installed, configure
	if is-snap; then
		# log start
		echo-segment --h2='Configure snap'

		# ensure snap is discoverable to the system
		if test ! -d /snap; then
			sudo-helper -- ln -s /var/lib/snapd/snap /snap
		fi

		# ensure snap service is running
		if service-helper --supported; then
			service-helper --enable --start -- snapd.socket snapd.apparmor
		fi

		# install snap support for gnome-software (if it exists)
		if command-exists gnome-software; then
			# PAMAC='gnome-software-snap' \
			# Error: target not found: gnome-software-snap
			setup-util --optional --name='Snap via Gnome Software' "$@" \
				APT='gnome-software-plugin-snap' # UBUNTU
		fi

		# log success
		echo-segment --g2='Configure snap'
	fi
)

# fire if invoked standalone
if test "$0" = "${BASH_SOURCE[0]}"; then
	setup_util_snap "$@"
fi