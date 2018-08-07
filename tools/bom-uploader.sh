#!/bin/bash

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

# Sample: /home/ubuntu/test-bits as the folder to refer to the downloaded bits
# Replace 'canned-pks' with different minio bucket name as needed

./bom-mgmt upload-bits --bits "${CANNED_PKS_DIR}/test-bits" \
                       --bom "${BOM_DIR}/bom-for-canned-nsx-t-pks-harbor-install-v2.1.yml" \
                       --bucket "canned-pks"
