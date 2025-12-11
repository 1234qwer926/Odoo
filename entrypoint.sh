#!/bin/bash
set -e

echo "Starting Odoo 19 using /etc/odoo/odoo.conf ..."
exec odoo -c /etc/odoo/odoo.conf
