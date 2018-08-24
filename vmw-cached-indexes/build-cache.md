# Rebuilding the VMware Product Index Cached Templates
bom-mgmt tool uses  [apnex/vmw-cli](https://github.com/apnex/vmw-cli) tool to build indexes for a set of pre-specified VMware products and then downloads the bits as requested.

A set of cached indexes have been already saved, curated and templated for only downloading NSX-T binary install bits for versions 2.1, 2.2 and Ovftool v4.2+.

These indexed files would be copied over when bom-downloader script is ran, to save time in looking up the right product families and download things faster.

To re-download or refresh full indexes, one would need to rerun the [apnex/vmw-cli](https://github.com/apnex/vmw-cli) tool to refresh the cached indexes. This runs as a docker image. So, would need docker cli already installed.

Run following steps:
```
export VMWUSER=myvmwareuser VMWPASS=myvmware_password
docker pull apnex/vmw-cli
mkdir cache

# Ensure no proxy is interferring with the outbound connection when docker image runs.
docker run -e VMWUSER -e VMWPASS -v ${PWD}/cache:/files apnex/vmw-cli list
docker run -e VMWUSER -e VMWPASS -v ${PWD}/cache:/files apnex/vmw-cli index vmware-nsx-t-data-center
docker run -e VMWUSER -e VMWPASS -v ${PWD}/cache:/files apnex/vmw-cli index vmware-pivotal-container-service
# WARNING!! This last step can run for 5+ Minutes
echo "WARNING!! This last indexing of vmware-vsphere can run for 5+ Minutes!!"
docker run -e VMWUSER -e VMWPASS -v ${PWD}/cache:/files apnex/vmw-cli index vmware-vsphere
```

##  To test the built cached index, run following tests
```
docker run -e VMWUSER -e VMWPASS -v ${PWD}/cache:/files apnex/vmw-cli find fileName:ovftool*
docker run -e VMWUSER -e VMWPASS -v ${PWD}/cache:/files apnex/vmw-cli find fileName:nsx-*
```

## Updating the cached index templates
Save the generated `fileIndex.json` and `mainIndex.json` from the `cache` folder, clean up things that are not required and save as templates back under `vmw-cached-templates` folder.
