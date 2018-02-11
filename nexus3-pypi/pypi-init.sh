#!/usr/bin/env bash

NEXUS3_BASE_URL="http://localhost:8081"
NEXUS3_SCRIPT_URL="${NEXUS3_BASE_URL}/service/siesta/rest/v1/script"

printf 'Waiting for server start'

until $(curl --output /dev/null --silent --head --fail "${NEXUS3_BASE_URL}"); do
    printf '.'
    sleep 1
done

echo

# if the repository already exists, just exit
if $(curl --output /dev/null --silent --head --fail "${NEXUS3_BASE_URL}/service/siesta/rest/beta/assets?repositoryId=pypi"); then
    echo "The repository exists, no actions required"
    exit 0
fi

# else create the repo
curl -v -X POST -u admin:admin123 --header "Content-Type: application/json" "${NEXUS3_SCRIPT_URL}" -d @/tmp/pypi.json
curl -v -X POST -u admin:admin123 --header "Content-Type: text/plain" "${NEXUS3_SCRIPT_URL}/pypi/run"
echo "The repository has been created"
