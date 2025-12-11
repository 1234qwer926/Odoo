FROM odoo:19

USER root

# Create custom directories
RUN mkdir -p /mnt/custom-addons /var/log/odoo && \
    chown -R odoo:odoo /mnt/custom-addons /var/log/odoo

# Create Python venv for custom packages (PEP 668 fix)
RUN python3 -m venv /opt/odoo-venv
ENV PATH="/opt/odoo-venv/bin:$PATH"

# Install python dependencies safely inside venv
COPY requirements.txt /tmp/requirements.txt
RUN if [ -s /tmp/requirements.txt ]; then \
        /opt/odoo-venv/bin/pip install --upgrade pip && \
        /opt/odoo-venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt ; \
    fi

# Copy Odoo config + addons
COPY docker/odoo.conf /etc/odoo/odoo.conf
COPY docker/addons /mnt/custom-addons

# Permissions
RUN chown -R odoo:odoo /etc/odoo /mnt/custom-addons

USER odoo

# Entrypoint
CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
