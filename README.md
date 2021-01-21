# adb_bash

 - a magisk module that make "adb shell" colorful

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

so you can add this line to /data/adb_home/.bashrc
```
alias su='su -p -c "bash --rcfile /data/adb_home/.bashrc"'
```
