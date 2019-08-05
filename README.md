# Wocker

A Wordpress Docker development environment that helps you migrate back and forth between live and local environments.

## Getting started

### Fresh Wordpress install

Run the following commands to create a fresh Wordpress install, with defaults from the `.env.example` file.

To edit these options run `cp .env.example .env` and modify whatever you wish in the `.env` file.

```bash
$ ./autogen.sh
Will create/update the wordpress container

$ ./autogen.sh --clean
Will also wipe any previous installation
```

### Migrate from live versions

First, upload the following files:

* `dump.sql`: your exported database file as SQL statements;
* `wp-content.zip`: your wp-content folder which contains themes, plugins and image uploads, zipped for convenience.

After that, refer to the **Migrate SQL** section of `.env` file and update your live and local website URLs.

Optionally, update the Docker images from the **Server config** section of `.env` file based on your live server configuration.

Finally, run the same command as before.

```bash
$ ./autogen.sh
Will create/update the wordpress container using your config data
```

## License

This project is open-source software licensed under the [MIT license](https://opensource.org/licenses/MIT).
