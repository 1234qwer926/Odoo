FROM odoo:19

USER root

# Install required packages for builds
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create custom addons + log directory
RUN mkdir -p /mnt/custom-addons /var/log/odoo \
    && chown -R odoo:odoo /mnt/custom-addons /var/log/odoo

# Copy configuration file
COPY docker/odoo.conf /etc/odoo/odoo.conf
RUN chown odoo:odoo /etc/odoo/odoo.conf

# Install Python requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

USER odoo

CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
