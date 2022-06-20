**Before Installing Chart**

1. Make sure to add a symbolic link to the directory that contains the JWT  Keys inside the chart folder, the reason for this is that at the moment it is not possible to reference files outside the chart folder, this is being worked on [here](https://github.com/helm/helm/pull/8841), run this command inside the hashed-private chart dir:

`ln -s /home/user/vsc-workspace/hashed-private-server/jwt-keys/test jwt-keys`

2. Set the jwt.localKeyPath value to the directory created with the previous command

**After Installing Chart**

The hasure metadata and migrations have to be applied and reloaded:

1. Apply metadata:

`../node_modules/hasura-cli/hasura metadata apply --endpoint https://hp-gql-dev.hashed.systems --admin-secret="secret"`

2. Apply migrations:

`../node_modules/hasura-cli/hasura migrate apply --all-databases --endpoint https://hp-gql-dev.hashed.systems --admin-secret="secret"`

3. Reload metadata:

`../node_modules/hasura-cli/hasura metadata reload --endpoint https://hp-gql-dev.hashed.systems --admin-secret="secret`
