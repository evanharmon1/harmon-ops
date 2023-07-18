# Plex Docker Setup

## env
- Set non-sensitive environment variables in the docker-compose.yml file.
- Set sensitive environment variables in the `plex.env` file referenced in `docker-compose`.yml.

## Persistent Storage
Bind mount from:
~/Local/Docker/plexms
