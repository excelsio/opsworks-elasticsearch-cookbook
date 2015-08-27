#!/bin/bash
#

set -euo pipefail

ES_HOSTNAME=${1:?"ElasticSearch hostname missing"}
BACKUP_NAME=${2:?"No ES backup name specified"}

SNAP_NAME="snap-$(date +%Y-%m-%d_%H:%M:%S)"

curl -XPUT "http://${ES_HOSTNAME}:9200/_snapshot/${BACKUP_NAME}/${SNAP_NAME}?wait_for_completion=true"
