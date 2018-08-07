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
