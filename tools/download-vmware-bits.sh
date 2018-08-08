#!/bin/bash

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

MY_VMWARE_USER=$(cat ${BOM_DIR}/${DEFAULT_BOM_FILE} | grep myvmware_user | awk '{print $NF}' )
MY_VMWARE_PASSWORD=$(cat ${BOM_DIR}/${DEFAULT_BOM_FILE} | grep myvmware_password | awk '{print $NF}' )

echo '{ "username": "'$MY_VMWARE_USER'", "password": "'$MY_VMWARE_PASSWORD'"}' > config.json

echo "Starting docker image for downloading vmware related bits!"

docker run -v ${PWD}:/vmwfiles apnex/myvmw
docker run -v ${PWD}:/vmwfiles apnex/myvmw "VMware Pivotal Container Service" 2>/dev/null

# Currently dont know the product family to download the ovftool
for named_vmware_bit in $(cat ${BOM_DIR}/${DEFAULT_BOM_FILE} \
                        | grep -C2 "my.vmware.com" \
                        | grep "name" \
                        | awk -F 'name: ' '{print $2}' )
do
  # Skip trying to download ovftool
  download_vmware_bit=$(cat ${BOM_DIR}/${DEFAULT_BOM_FILE} \
                          | grep -A4 "$named_vmware_bit" \
                          | grep "my.vmware.com" \
                          | grep -v "ovftool"
                          | awk -F '#' '{print $2}' )

  echo "Downloading bit: ${download_vmware_bit} from my.vmware.com"
  docker run -v ${PWD}:/vmwfiles apnex/myvmw get ${download_vmware_bit} 2>/dev/null
  mv ${download_vmware_bit} ${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}/resources/file/${named_vmware_bit}
  echo "Saving bit as ${CANNED_PKS_DIR}/${DOWNLOAD_BITS_FOLDER}/resources/file/${named_vmware_bit}"
  echo ""
done

echo "Finished downloading vmware related bits from my.vmware.com!!"
echo "Skipped downloading ovftool!!"
echo ""
