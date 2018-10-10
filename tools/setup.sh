#!/bin/bash


export ROOT_DIR=`pwd`

export TOOLS_DIR=$(dirname $BASH_SOURCE)
export CANNED_PKS_DIR=$(cd $TOOLS_DIR/.. && pwd)
export BOM_DIR=$(cd $CANNED_PKS_DIR/bom && pwd)

# EDIT ME if necessary
export DOWNLOAD_BITS_FOLDER="download-bits"

# EDIT ME
export MINIO_HOST="<MINIO_HOST>:<MINIO_PORT>"
export MINIO_ACCESS_KEY="<minio_access_id>"
export MINIO_SECRET="<minio_secret_access_key>"

# EDIT ME
export MINIO_BUCKET="canned-pks"

# EDIT if necessary
# Use the 2.2 or 2.3 bom file version if planning to install NSX-T v2.2/2.3 versions
#export DEFAULT_BOM_FILE=bom-for-canned-nsx-t-pks-harbor-install-v2.2.yml
#export DEFAULT_BOM_FILE=bom-for-canned-nsx-t-pks-harbor-install-v2.3.yml
export DEFAULT_BOM_FILE=bom-for-canned-nsx-t-pks-harbor-install-v2.1.yml

which docker
docker_status=$?
if [ "$docker_status" != "0" ]; then
  echo "Docker not installed or not available for current user!!, Exiting"
fi

which unzip
unzip_status=$?
if [ "$unzip_status" != "0" ]; then
  echo "Unzip not installed!!, Exiting"
fi

which python
python_status=$?
if [ "$python_status" != "0" ]; then
  echo "Python not installed!!, Exiting"
fi
