```
sudo docker run -ti --rm -p 5432:5432 --name blackbox -v /home/jose/launchpad/blackbox/:/blackbox launchpad/blackbox bash
```
```
PGUSER=deploy PGDATABASE=blackbox PGPASSWORD=docker node create-tables.js
```
