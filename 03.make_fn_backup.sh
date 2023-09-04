#!/bin/bash
source ./00.env.sh

find ${WORKPATH}/*/*.sh > ./13.run_fn_backup.sh
sed -i 's/^/sh /g' ./13.run_fn_backup.sh
