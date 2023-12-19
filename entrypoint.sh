#!/bin/bash

# Path to the config directory in the bind mount
CONFIG_DIR="/var/www/html/resourcespace"
CONFIG_FILE="$CONFIG_DIR/config.php"

# Check if the config directory is empty
if [ ! -e $CONFIG_FILE ]; then
    echo "Config file is missing. Populating with default config."
    cp -R /app/* $CONFIG_DIR/
else
    echo "Config directory is not empty. Proceeding with existing configuration."
fi

chown -R 1000:1000 $CONFIG_DIR
chmod 777 $CONFIG_DIR/filestore
chmod -R 777 $CONFIG_DIR/include/

# Execute the main command
/usr/sbin/apachectl -D FOREGROUND