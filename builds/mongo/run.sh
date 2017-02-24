#!/bin/bash
# allow usage of 'bg' and 'fg'
set -m


# Start mongodb
mongod --smallfiles --auth &

# Wait for mongodb to startup
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 1
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

# Create mongo admin
echo "=> Creating an admin"
mongo admin << EOF
db.createUser({
    user: '$ADMIN_USER',
    pwd: '$ADMIN_PASS',
    roles: [ {role:'root', db:'admin'} ]
});
EOF

# Create mongo user
echo "=> Creating a user"
mongo admin -u $ADMIN_USER -p $ADMIN_PASS << EOF
use $MONGO_DB
db.createUser({
    user: '$MONGO_USER',
    pwd: '$MONGO_PASS',
    roles: [ {role:'dbOwner', db:'$MONGO_DB'} ]
})
EOF

echo "=> Done!"

# Bring back app in background
fg
