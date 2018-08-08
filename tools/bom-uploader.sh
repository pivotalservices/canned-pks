#!/bin/bash

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

# Sample: /home/ubuntu/test-bits as the folder to refer to the downloaded bits
# Replace 'canned-pks' with different minio bucket name as needed

if [ ! -e "$TOOLS_DIR/bom-mgmt" ]; then
  echo "bom-mgmt tool not available in current folder, run $TOOLS_DIR/download-tools.sh before running this script. Exiting!"
fi

$TOOLS_DIR/bom-mgmt upload-bits --bits "${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}" \
                               --bom  "${BOM_DIR}/${DEFAULT_BOM_FILE}" \
                               --bucket "${MINIO_BUCKET}"
