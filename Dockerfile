FROM odoo:17

USER root

# Copy config
COPY docker/odoo.conf /etc/odoo/odoo.conf

# Copy custom addons
COPY docker/addons /mnt/custom-addons

RUN chown -R odoo:odoo /mnt/custom-addons

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER odoo

ENTRYPOINT ["/entrypoint.sh"]
