# Use official Odoo 19 image
FROM odoo:19

USER root

# Create addons directory
RUN mkdir -p /mnt/custom-addons /var/log/odoo && chown -R odoo:odoo /mnt/custom-addons /var/log/odoo

# Copy config and addons
COPY docker/odoo.conf /etc/odoo/odoo.conf
COPY docker/addons /mnt/custom-addons

# Install extra Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN if [ -s /tmp/requirements.txt ]; then \
      python3 -m pip install --no-cache-dir -r /tmp/requirements.txt ; \
    fi

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown odoo:odoo /entrypoint.sh

USER odoo

ENTRYPOINT ["/entrypoint.sh"]
