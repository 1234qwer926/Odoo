#!/bin/bash
set -e

# Wait for postgres to be ready
echo "Waiting for PostgreSQL..."
until PGPASSWORD=$db_password psql -h "$db_host" -U "$db_user" -d "$db_name" -c '\q' 2>/dev/null; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "PostgreSQL is up - starting Odoo"

# Start Odoo with the config file and database parameters
exec odoo \
  -c /etc/odoo/odoo.conf \
  --db_host="$db_host" \
  --db_port="$db_port" \
  --db_user="$db_user" \
  --db_password="$db_password" \
  --database="$db_name" \
  --db-filter="^$db_name\$" \
  --no-database-list