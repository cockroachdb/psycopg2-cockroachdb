# Run psycopg2 test suite against CockroachDB

Usage:

```
docker-compose up -d cockroachdb

# to test psycopg master
docker-compose run --rm psycopg2

# to test a certain psycopg branch
docker-compose run --rm -e BRANCH=branch_name psycopg2

# to test psycopg from a directory on the host
docker-compose run --rm -v /host/path/to/psycopg2:/psycopg2 psycopg2
```
