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

# run a specific test module, class, function
docker-compose run --rm -e TEST=tests.test_async.AsyncTests.test_async_select psycopg2

# report of the reason why tests was skipped:
docker-compose run --rm -e TEST=tests.test_types_extras \
    | grep skipped.*CockroachDB \
    | sed "s/.* skipped '\(.*\)'/\1/" \
    | sort | uniq -c

     13 not supported on CockroachDB: composite
      9 not supported on CockroachDB: hstore
     16 not supported on CockroachDB: json
     14 not supported on CockroachDB: range
```
