# jee_deploy
Deploy to arbitrary javaapplication server from command line

#### SYNOPSIS
./jee_deploy server [add|list|delete] [--alias, --type, --hostname, --port, --mgmt_url, --username, --password]

./jee_deploy app [deploy|undeploy|delete|list|ping] [--filename, --server_alias]

./jee_deploy --config file.json

DB_FILE=external_db_file DEBUG=1 ./jee_deploy ...


#### RUN JEE_DEPLOY IN DOCKER
```bash
docker build -t local/tomcat ./docker/tomcat
docker build -t local/perl   ./docker/perl
docker network create mynet
docker run -d  --network mynet --name tomcat --rm -p 8080:8080 local/tomcat
docker run -it --network mynet --name perl5  --rm local/perl
DEBUG=1 ./jee_deploy --config sample_scenario.json
# then visit http://localhost:8080/sample
```

