# Document Cache Helm Chart

Installs the following components:

- Dgraph
- Document cache stream processor

View the values.yml.example for an example of the parameters that can be configured, another good source to understand the configuration parameters is the values.schema.json file that is used to validate them.

Some important configuration parameters are:

- url.domain:
  - base: The base domain name to be used
  - alpha: The subdomain to be used for dgraph alpha
  - ratel: The subdomain to be used for dgraph ratel
  - prometheus: The subdomain to be used for prometheus
- env: The values under env map to the values in the config.yml of the document cache stream processor, although the configuration parameters names are written in camel case instead of kebab case 
- dgraph.ratel.enabled: To enable/disable ratel