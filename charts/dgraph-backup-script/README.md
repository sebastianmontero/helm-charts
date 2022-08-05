# Dgraph Backup Script Helm Chart

Installs the following components:

- Dgraph backup script

View the values.yml.example for an example of the parameters that can be configured, another good source to understand the configuration parameters is the values.schema.json file that is used to validate them.

Some important configuration parameters are:

- env: The values under env map to the values in the config.yml of the dgraph backup script, although the configuration parameters names are written in camel case instead of kebab case