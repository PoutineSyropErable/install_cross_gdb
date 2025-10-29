#!/usr/bin/env bash
set -euo pipefail

# Helper function to create symlink if it doesn't exist
link_if_not_exists() {
	local target="$1"
	local link="$2"
	if [[ ! -e "$link" ]]; then
		sudo ln -s "$target" "$link"
		echo "Linked $link -> $target"
	else
		echo "Symlink $link already exists, skipping"
	fi
}

# i686 cross-GDB
link_if_not_exists "$HOME/cross-gdb/install-i686/bin/i686-elf-gdb" "/usr/local/bin/i686-elf-gdb"

# x86_64 cross-GDB
link_if_not_exists "$HOME/cross-gdb/install-x86_64/bin/x86_64-elf-gdb" "/usr/local/bin/x86_64-elf-gdb"

# ia16 cross-GDB (if needed)
link_if_not_exists "$HOME/cross-gdb/install-ia16/bin/ia16-elf-gdb" "/usr/local/bin/ia16-elf-gdb"
