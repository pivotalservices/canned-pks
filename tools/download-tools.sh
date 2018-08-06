#!/bin/#!/usr/bin/env bash

wget https://dl.minio.io/client/mc/release/linux-amd64/mc
chmod +x mc

wget https://github.com/concourse/concourse/releases/download/v4.0.0/fly_linux_amd64
mv fly_linux_amd64 fly
chmod +x fly

# Edit version to pull the latest release bits
VERSION=1.0.1
wget https://github.com/pivotalservices/bom-mgmt/releases/download/v${VERSION}/bom-mgmt-linux
mv bom-mgmt-linux bom-mgmt
chmod +x bom-mgmt
