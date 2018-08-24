#!/bin/bash

export ROOT_DIR=`pwd`

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

if [ ! -e "$TOOLS_DIR/bom-mgmt" ]; then
  echo "bom-mgmt tool not available in current folder, run $TOOLS_DIR/download-tools.sh before running this script. Exiting!"
fi

# Sample: ${CANNED_PKS_DIR}/test-bits is a folder to save the downloaded bits
# Copy over the pre-cached vmware product indexes into <download-bits>/resources/vmware
# This folder would be used as the mount path for the apnex/vmw-cli docker image
mkdir -p ${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}/resources/vmware
cp $CANNED_PKS_DIR/vmw-cached-indexes/*.json \
   ${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}/resources/vmware

$TOOLS_DIR/bom-mgmt download-bits --bits "${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}" \
                         --bom  "${BOM_DIR}/${DEFAULT_BOM_FILE}"
DOWNLOAD_STATUS=$?

if [ "$DOWNLOAD_STATUS" == "0" ]; then
  echo "Finished downloading bill of materials"
  echo ""
  exit 0
else
  echo "Error in downloading bill of materials"
  echo "Check permissions or details of the errors, fix them and retry"
  echo ""
  exit -1
fi
