#!/bin/bash
set -e

source ~/work/defir/.config

if [ $# -gt 1 ]; then
  echo "usage $0 [description]"
  exit 1
fi

if [ $# -eq 1 ]; then
  DESC="${1}"
else
  DESC=${TITLE}
fi
#git push origin HEAD
#curl --header "Private-Token: ${TOKEN}" --header "Content-Type: application/json" -X POST -d "{\"source_branch\":\"${S_BRANCH}\", \"target_branch\":\"${T_BRANCH}\", \"title\":\"${TITLE}\", \"description\": \"${DESC}\", \"assignee_id\": ${ASSIGNEE}}" "${URL}"


edit()
{
  if [ $EDITOR == "vim" ] 
  then
    param="+"
  fi
  tmp_mes=$(mktemp)
  echo "chef_role:" > ${tmp_mes}
  echo "***" >> ${tmp_mes}
  $EDITOR ${param} ${tmp_mes} 3>&1 1>&2 2>&3
  cat ${tmp_mes}
  cp ${tmp_mes} /tmp/11
  rm -f ${tmp_mes}
}

tmp_desc=$(edit)
desc=""
for line in ${tmp_desc}
do
  desc="${desc}${line}\\r\\n"
done

echo ${desc}
