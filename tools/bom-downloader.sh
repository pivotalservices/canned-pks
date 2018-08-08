#!/bin/bash

export ROOT_DIR=`pwd`

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

# Sample: ${CANNED_PKS_DIR}/test-bits is a folder to save the downloaded bits
./bom-mgmt download-bits --bits "${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}" \
                         --bom  "${BOM_DIR}/${DEFAULT_BOM_FILE}"
echo "Finished downloading Github Repos, Docker images, Pivnet related dependencies!!"
echo ""

./download-vmware-bits.sh

echo "Finished downloading all related bill of materials"
echo ""
