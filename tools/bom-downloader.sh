#!/bin/bash

export ROOT_DIR=`pwd`

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh


# Sample: ${CANNED_PKS_DIR}/test-bits is a folder to save the downloaded bits
./bom-mgmt download-bits --bits "${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}" \
                         --bom "../bom/bom-for-canned-nsx-t-pks-harbor-install-v2.1.yml"
