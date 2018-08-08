#!/bin/bash

export ROOT_DIR=`pwd`

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

if [ ! -e "$TOOLS_DIR/bom-mgmt" ]; then
  echo "bom-mgmt tool not available in current folder, run $TOOLS_DIR/download-tools.sh before running this script. Exiting!"
fi

# Sample: ${CANNED_PKS_DIR}/test-bits is a folder to save the downloaded bits
$TOOLS_DIR/bom-mgmt download-bits --bits "${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}" \
                         --bom  "${BOM_DIR}/${DEFAULT_BOM_FILE}"
echo "Finished downloading Github Repos, Docker images, Pivnet related dependencies!!"
echo ""

$TOOLS_DIR/download-vmware-bits.sh

echo "Finished downloading bill of materials"
echo ""
