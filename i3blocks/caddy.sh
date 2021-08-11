#!/bin/bash

status=$(systemctl show -p SubState --value caddy.service)

echo "Caddy: $status"
