#!/bin/bash
FILENAME='deploy/cold'

STAGE=$1
BRANCH=$2
echo "STAGE=${STAGE}"
echo "BRANCH=${BRANCH}"

if [ -f "${FILENAME}" ]; then
  echo "----- bundle exec cap ${STAGE} deploy:stop ----- "
  bundle exec cap ${STAGE} deploy:stop
  echo "----- bundle exec cap ${STAGE} deploy BRANCH=${BRANCH} ----- "
  bundle exec cap ${STAGE} deploy BRANCH=${BRANCH}
else
  echo "----- bundle exec cap ${STAGE} deploy BRANCH=${BRANCH} ----- "
  bundle exec cap ${STAGE} deploy BRANCH=${BRANCH}
fi
