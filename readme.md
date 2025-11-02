
```bash
git clone https://github.com/PoutineSyropErable/install_cross_gdb ~/cross-gdb-new/ --depth=1
cd ~/cross-gdb
./install.sh
```


You need python3.11 and gcc12 
So, for arch linux, a yay -S is done

Then, the binutils-2.45 and gdb-16.3 are downloaded, compiled and installed to the local dir here. 
Then, it's symlinked to /usr/local/bin for syswide availability
