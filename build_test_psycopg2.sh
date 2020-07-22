#!/bin/bash

set -euo pipefail
set -x

branch=${BRANCH:-master}
test=${TEST:-tests.test_suite}


# Download if needed, build, install psycopg2
if [[ ! -d /psycopg2 ]]; then
    git -C / clone --branch ${branch} https://github.com/psycopg/psycopg2.git
fi

cd /psycopg2
python setup.py build install

export PGUSER=root
export PGHOST=cockroachdb
export PGPORT=26257
export PGSSLMODE=disable
export PSYCOPG2_TESTDB=psycopg2_test

# Create the test database
python <<HERE
import psycopg2
conn = psycopg2.connect("")
conn.autocommit = True
curs = conn.cursor()
curs.execute("CREATE DATABASE IF NOT EXISTS ${PSYCOPG2_TESTDB}")
HERE

# Run the test suite
python -c "import tests; tests.unittest.main(defaultTest='${test}')" \
    --verbose
