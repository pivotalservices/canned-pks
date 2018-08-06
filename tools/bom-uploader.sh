#!/bin/bash

# EDIT ME
export MINIO_HOST="<MINIO_HOST>:<MINIO_PORT>"
export MINIO_ACCESS_KEY="<minio_access_id>"
export MINIO_SECRET="<minio_secret_access_key>"

# Sample: /home/ubuntu/test-bits as the folder to refer to the downloaded bits
# Replace 'canned-pks' with different minio bucket name as needed

./bom-mgmt upload-bits --bits "/home/ubuntu/test-bits" \
                       --bom "bom/bom-for-canned-nsx-t-pks-harbor-install-v2.1.yml" \
                       --bucket "canned-pks"
