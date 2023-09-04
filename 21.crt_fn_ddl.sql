/*
Usage : psql -d {DBNAME} -f 21.crt_fn_ddl.sql > /home/gpadmin/gpconfigs/fn20230808/{DBNAME}/21.crt_fn_ddl.{DBNAME}.sh
*/

SELECT 'psql -d ' || org.dbname || ' -c "\sf ' || org.nspname || '.' || org.proname || '(' || array_to_string(org.arg_val,',') || ')" > ' || :val || '/' || org.dbname || '/' || org.nspname || '.' || org.proname || '_' || array_to_string(org.arg_val,',')
FROM
	(SELECT st.dbname
	, st.nspname
	, st.proname
	, st.lanname
	, array_agg(pt.typname order by st.arg_idx) AS arg_val
	, st.return_type
	FROM
		(SELECT current_database() AS dbname
		, pn.nspname AS nspname
		, pp.oid AS proc_oid
		, pp.proname AS proname
		, pl.lanname AS lanname
		, unnest(pp.proargtypes) AS arg_val
		, generate_subscripts(pp.proargtypes, 1) AS arg_idx
		--, pg_get_function_identity_arguments(pp.oid) AS arg_val
		, pg_get_function_result(pp.oid) AS return_type
		--, pg_get_functiondef(pp.oid) AS obj_def
		FROM pg_proc AS pp
		INNER JOIN pg_namespace AS pn on (pp.pronamespace = pn.oid)
		INNER JOIN pg_language AS pl on (pp.prolang = pl.oid)
		WHERE pl.lanname NOT IN ('c','internal','sql','plpgsql')
		AND pn.nspname NOT LIKE 'pg_%'
		AND pn.nspname NOT IN ('information_schema','madlib','gp_toolkit')
		ORDER BY 1,2
		) AS st
		INNER JOIN pg_type AS pt on (st.arg_val = pt.oid)
		GROUP BY st.dbname, st.nspname, st.proname, st.lanname, st.return_type, st.proc_oid
	) AS org
;
