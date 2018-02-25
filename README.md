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
docker run -d --name tomcat --rm -P local/tomcat
docker run -it --name perl5 --rm --link tomcat:tomcat local/perl
DEBUG=1 ./jee_deploy --config sample_scenario.json
```

