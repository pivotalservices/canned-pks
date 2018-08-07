#!/bin/bash

export BOM_MGMT_VERSION=1.0.1

export TOOLS_DIR=$(dirname $BASH_SOURCE)
source $TOOLS_DIR/setup.sh

wget https://dl.minio.io/client/mc/release/linux-amd64/mc
chmod +x mc

wget https://github.com/concourse/concourse/releases/download/v4.0.0/fly_linux_amd64
mv fly_linux_amd64 fly
chmod +x fly

# Edit version to pull the latest release bits

wget https://github.com/pivotalservices/bom-mgmt/releases/download/v${BOM_MGMT_VERSION}/bom-mgmt-linux
mv bom-mgmt-linux bom-mgmt
chmod +x bom-mgmt
