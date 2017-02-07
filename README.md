# Packebian Backend Controller environment

## Services and containers in the composition
- sails (1 container)
- mysql (1 container)

## Volumes
- `./data/sails` : This folder must be the root of a sails project. If it is empty, a sails project will be created at the creation of the sails container.
- `mysqlVolume` : Named volume containing the data created by the mysql database


## Access to a container
Using docker-compose, it is possible to access to the running containers and to execute commands directly in them.

The following command will open an interactive `bash` in the container `sails`.
```sh
$ docker-compose exec sails bash
```
The next one will install the module MODULE and save it in the package.json file in the container `sails`.
```sh
$ docker-compose exec sails bash -c "npm install --save MODULE"
```

## Configure sails

### RESTful routes
In the file `config/blueprints.js`, set the following variables to use RESTFul routes
```js
actions: false,
rest: true,
shortcuts: false,
pluralize: true
```

### Connection to database
To use mysql, the module `sails-mysql` must be installed. The best way to install it is to put it the project dependencies. That way, it will be installed when the sails application is first lifted. To do so, add the module in the `package.json` file by running the following command at the root of your sails project.
```sh
$ npm install sails-mysql --save
```

Or by running a command directly in the sails container :
```sh
$ docker-compose exec sails bash -c "npm install --save sails-mysql"
```

Then, update the file `config/connection.js` using the right parameters. http://sailsjs.com/documentation/concepts/models-and-orm

Also, modify the file `config/models.js` to set which connection is used and which migration politics to use.
