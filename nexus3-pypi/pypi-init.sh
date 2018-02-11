#!/usr/bin/env bash

NEXUS3_BASE_URL="http://localhost:8081"
NEXUS3_SCRIPT_URL="${NEXUS3_BASE_URL}/service/rest/v1/script"

printf 'Waiting for server to start'

until $(curl --output /dev/null --silent --head --fail "${NEXUS3_BASE_URL}"); do
    printf '.'
    sleep 2
done

echo

# if the repository already exists, just exit
if $(curl --output /dev/null --silent --head --fail "${NEXUS3_BASE_URL}/service/rest/beta/assets?repository=pypi"); then
    echo "The repository exists, no actions required"
    exit 0
fi

# else upload the script
curl -X POST \
     -u admin:admin123 \
     --header "Content-Type: application/json" \
     --header "Accept: application/json" \
     -d @/tmp/pypi.json \
     "${NEXUS3_SCRIPT_URL}"

if [ $? -eq 0 ]
then
  echo "Successfully uploaded the script to repo"
else
  echo "Could not upload script" >&2
  exit 1
fi

# and create the repo
curl --output /dev/null --silent -X POST \
     -u admin:admin123 \
     --header "Content-Type: text/plain" \
     "${NEXUS3_SCRIPT_URL}/pypi/run"

if [ $? -eq 0 ]
then
  echo "The repository has been created"
else
  echo "Could not run the script" >&2
  exit 1
fi