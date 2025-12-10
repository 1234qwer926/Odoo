# Odoo Deployment on Render (Docker)

This repository contains a complete setup for deploying Odoo on Render using Docker.

## Steps to Deploy

1. Push this repository to GitHub.
2. Go to Render → New Web Service → Deploy from GitHub.
3. Select this repo.
4. Render will automatically read `render.yaml`, create:
   - A PostgreSQL database
   - A Docker-based Odoo app
5. After deployment, open the URL:

