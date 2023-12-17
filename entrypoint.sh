#!/bin/bash

# Path to the config directory in the bind mount
CONFIG_DIR="/var/www/html"
CONFIG_FILE="$CONFIG_DIR/config.php"

# Check if the config directory is empty
if [ -z "$(ls -A $CONFIG_FILE)" ]; then
    echo "Config directory is empty. Populating with default config."
    cp -R /var/www/resourcespace/* $CONFIG_DIR/
else
    echo "Config directory is not empty. Proceeding with existing configuration."
fi

# Adjust permissions if necessary
chown -R 1000:1000 $CONFIG_DIR

# Execute the main command
/usr/sbin/apachectl -D FOREGROUND
