# adb_bash

 - a magisk module that make "adb shell" colorful

[简体中文](README_zh-CN.md)

# What it used for?

 - I believed that everyone used bash may thinking a question:

> _Why Android shell (`/system/bin/sh`) is mksh?_

 - maybe some system app developers are interested in mksh, but NOT ME!

 - so I need a bash...at least for adb shell.

# Install

download [releases](https://github.com/Sodium-Aluminate/adb_bash/releases) or just zip everything in repo.
And install by magisk manager.

# Uninstall

1. uninstall the module in magisk manager(or `rm -rf /data/adb/modules/adb_bash` in recovery in case you messed up something)

2. delete /data/adb_home dir... If you have OCD :)

3. ~~Contact the author and blame the module~~

# How this module works?

the `/system/bin/sh` is mksh, so it will read /etc/mkshrc.

`/etc` is linked to `/system/etc`

so the module add sctipts to file: `/system/etc/mkshrc`

(and to avoid other bugs, I keep the orginal script in mkshrc.)

the script will check uid=2000 (adb) and running interactively then switch shell to bash with a rc file

# what should I do if I want keep bash after su?

even you run `su -s bash`, you will found that `$0` is /system/bin/sh

the only way to avoid is exec bash as a command(su -c)

so you can add this line to /data/adb_home/.bash_aliases

```
alias su='su -p -c "bash --rcfile /data/adb_home/.bashrc"'
```

# troubleshooting

## not working
 - try `/data/adb/modules/adb_shell/system/bin/bash` or `bash` as rooted shell/adb shell
 1. if root can execute but not adb, chmod and chcon it.
 2. in case of even root cann't execute it after chmod+x, maybe CPU architecture not match. [cross compile](https://github.com/floyd-fuh/ARM-cross-compile/blob/master/ubuntu-compile-bash.sh)  another bash.
 - adb shell and cat /data/adb_home/.bashrc, if not working, chcon and chmod it.
 - pay attention of the fact that `su 2000` have different SELinux context.
 
## bootloop or something else worse
 - `rm -rf /data/adb/modules/adb_bash` or `touch /data/adb/modules/adb_bash/disable` can disable module if your recovery is TWRP.
 - check if orginal mkshrc (/etc/mkshrc) have anything special commands (maybe other module edited this file?)
