#!/usr/bin/env bash

# i686 cross-GDB
sudo ln -s ~/cross-gdb/install-i686/bin/i686-elf-gdb /usr/local/bin/i686-elf-gdb

# x86_64 cross-GDB
sudo ln -s ~/cross-gdb/install-x86_64/bin/x86_64-elf-gdb /usr/local/bin/x86_64-elf-gdb

# ia16 cross-GDB (if needed)
sudo ln -s ~/cross-gdb/install-ia16/bin/ia16-elf-gdb /usr/local/bin/ia16-elf-gdb
