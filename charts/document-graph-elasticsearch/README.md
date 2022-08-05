# Document Graph Elastic Search Stream processor Helm Chart

Installs the following components:

- Document graph elastic search stream processor

View the values.yml.example for an example of the parameters that can be configured, another good source to understand the configuration parameters is the values.schema.json file that is used to validate them.

Some important configuration parameters are:

- url.domain:
  - base: The base domain name to be used
  - prometheus: The subdomain to be used for prometheus
- env: The values under env map to the values in the config.yml of the document graph elastic search stream processor, although the configuration parameters names are written in camel case instead of kebab case