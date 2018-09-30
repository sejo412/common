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
git push origin HEAD
curl --header "Private-Token: ${TOKEN}" --header "Content-Type: application/json" -X POST -d "{\"source_branch\":\"${S_BRANCH}\", \"target_branch\":\"${T_BRANCH}\", \"title\":\"${TITLE}\", \"description\": \"${DESC}\", \"assignee_id\": ${ASSIGNEE}}" "${URL}"
