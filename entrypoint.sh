#!/bin/bash
set -e

echo "Starting Odoo with custom config..."
exec odoo -c /etc/odoo/odoo.conf
