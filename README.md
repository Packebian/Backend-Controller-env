# Packebian Backend Controller environment

## Services and containers in the composition
- sails
- mongo


## Volumes
- `./data/sails` : This folder must be the root of a sails project. If it is empty, a sails project will be created at the creation of the sails container.
- `mongoVolume` : Named volume containing the data created by the mongo database


## Access to a container
Using docker-compose, it is possible to access to the running containers and to execute commands directly in them.

The following command will open an interactive `bash` in the container `sails`.
```sh
$ docker-compose exec sails bash
```


## Configure sails
The sails application in this configuration is created in the following github repository.
[Dockerfile](http://github.com/Packebian/Backend-controller)


## Configure mongodb
The mongodb database is created automatically at the creation of the container. The following environment variables can be used to configure the user, passwords and name of database that are created.
```sh
ADMIN_USER: "root"
ADMIN_PASS: "mongdb123"
MONGO_DB: "packebian"
MONGO_USER: "packebian"
MONGO_PASS: "packebian123"
```


### Connect to the database
The following command can be used to access to the `$MONGO_DB` database.
```js
$ docker-compose exec mongodb mongo $MONGO_DB -u $MONGO_USER -p $MONGO_PASS
```
