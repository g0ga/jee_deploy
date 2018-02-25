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
CONTAINER=$(docker run -it -d --name tomcat --rm -p 8080:8080 local/tomcat)
CONTAINER_IP=$(docker container inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER)
docker run -it -d --name perl5 --rm local/perl
docker exec perl5 bash -c "echo '$CONTAINER_IP tomcat' >> /etc/hosts"
docker attach perl5
DEBUG=1 ./jee_deploy --config sample_scenario.json
```

