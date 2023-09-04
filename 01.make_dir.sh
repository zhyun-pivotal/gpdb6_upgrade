#!/bin/bash
source ./00.env.sh

psql -t -c "select 'mkdir -p ${WORKPATH}/' || datname from pg_database where datname not in ('postgres','template0','template1','gpperfmon');" > 11.run_make_dir.sh
