#!/bin/bash

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

# Sample: /home/ubuntu/test-bits as the folder to refer to the downloaded bits
# Replace 'canned-pks' with different minio bucket name as needed

./bom-mgmt upload-bits --bits "${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}" \
                       --bom  "${BOM_DIR}/${DEFAULT_BOM_FILE}" \
                       --bucket "${MINIO_BUCKET}"
