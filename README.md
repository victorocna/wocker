# Wocker

A Wordpress Docker development environment that helps you migrate back and forth between live and local environments.

## Getting started

### Fresh Wordpress install

```bash
sh local.sh
```

This will create a Wordpress container with defaults from the `env-example.txt` file.

To edit these options run `cp env-example.txt .env` and modify whatever you wish in the `.env` file.

### Migrate from live versions

First, upload the following files:

* `dump.sql` -> your exported database file as SQL statements;
* `wp-content.zip` -> your wp-content folder which contains themes, plugins and image uploads, zipped for convenience.

After that, refer to the **Migrate SQL** section of `.env` file and update your live and local website URLs.

Optionally, update the Docker images from the **Server config** section of `.env` file based on your live server configuration.

Finally, run the same command as before.

```bash
sh local.sh
```

## Debugging

If you encounter errors while bringing up the Docker containers, run the following command. It will destroy **every** docker container and volume. If this doesn't work, just **Reset to factory defaults** from Docker Desktop settings.

```bash
sh nuke.sh
```

## License

This project is open-source software licensed under the [MIT license](https://opensource.org/licenses/MIT).
