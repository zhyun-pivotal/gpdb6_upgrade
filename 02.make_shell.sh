#!/bin/bash
source ./00.env.sh

echo "" > 12.run_make_shell.sh
psql -t -c "select 'psql -d ' || datname || ' -f 20.chk_fn_list.sql > ${WORKPATH}/20.chk_fn_list.' || datname from pg_database where datname not in ('postgres','template0','template1','gpperfmon');" >> 12.run_make_shell.sh
echo "" >> 12.run_make_shell.sh
psql -t -c "select 'psql -d ' || datname || ' -t -f 21.crt_fn_ddl.sql -v val="'"'"''${WORKPATH}''"'"'" > ${WORKPATH}/' || datname || '/21.crt_fn_ddl.' || datname || '.sh' from pg_database where datname not in ('postgres','template0','template1','gpperfmon');" >> 12.run_make_shell.sh
echo "" >> 12.run_make_shell.sh 
psql -t -c "select 'psql -d ' || datname || ' -t -f 22.update_fn_ddl.sql -v val="'"'"''${WORKPATH}''"'"'" > ${WORKPATH}/' || datname || '/22.update_fn_ddl.' || datname || '.sh' from pg_database where datname not in ('postgres','template0','template1','gpperfmon');" >> 12.run_make_shell.sh
echo "" >> 12.run_make_shell.sh
psql -t -c "select 'psql -d ' || datname || ' -t -f 23.crt_fn_owner.sql -v val="'"'"''${WORKPATH}''"'"'" > ${WORKPATH}/' || datname || '/23.crt_fn_owner.' || datname || '.sh' from pg_database where datname not in ('postgres','template0','template1','gpperfmon');" >> 12.run_make_shell.sh
echo "" >> 12.run_make_shell.sh
psql -t -c "select 'psql -d ' || datname || ' -t -f 24.crt_fn_grant.sql -v val="'"'"''${WORKPATH}''"'"'" > ${WORKPATH}/' || datname || '/24.crt_fn_grant.' || datname || '.sh' from pg_database where datname not in ('postgres','template0','template1','gpperfmon');" >> 12.run_make_shell.sh
