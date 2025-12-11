FROM odoo:19

USER root

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev build-essential postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create custom addons + log directory
RUN mkdir -p /mnt/custom-addons /var/log/odoo \
    && chown -R odoo:odoo /mnt/custom-addons /var/log/odoo

# Copy configuration file
COPY docker/odoo.conf /etc/odoo/odoo.conf
RUN chown odoo:odoo /etc/odoo/odoo.conf

# Copy custom entrypoint
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown odoo:odoo /entrypoint.sh

USER odoo

# Set environment variables for the entrypoint
ENV db_host=pg-3a7c5a5c-pk7386510581-d69d.j.aivencloud.com
ENV db_port=10644
ENV db_user=avnadmin
ENV db_password=AVNS_GCeUnuCwo2f-_zXRFQx
ENV db_name=defaultdb

ENTRYPOINT ["/entrypoint.sh"]