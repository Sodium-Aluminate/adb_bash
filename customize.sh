cp -R $MODPATH/adb_home /data/
chown -R shell:shell /data/adb_home
chmod 770 /data/adb_home
chcon -R u:object_r:shell_data_file:s0 /data/adb_home
chmod 755 $MODPATH/system/bin/bash
