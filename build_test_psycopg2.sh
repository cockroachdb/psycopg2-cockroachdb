#!/bin/bash

set -euo pipefail
set -x

branch=${BRANCH:-master}

# Download, build, install psycopg2
cd /
git clone --branch ${branch} https://github.com/psycopg/psycopg2.git
cd psycopg2
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
curs = conn.cursor()
curs.execute("CREATE DATABASE IF NOT EXISTS ${PSYCOPG2_TESTDB}")
HERE

# Run the test suite
python -c "import tests; tests.unittest.main(defaultTest='tests.test_suite')" \
    --verbose
