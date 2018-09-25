# FAQs

## Pre-reqs

  1) Online Access

    The Bill of Materials download step needs online access to:
    * Download the various tools (fly, bom-mgmt, mc)
    * Download the actual install bits.
  2) Docker and python setup on the Jumpbox machine
  3) DNS Setup access
  4) Resource Pools
  Resource pools specified for the NSX-T install or PKS install should exist.

## bom-downloader appears to hang or fail?

Ensure there is no proxy between the downloader client vm and Internet.
Remove/unset http_proxy env variable if its set. Also, downloading the vmware bits requires docker install (again with no proxy). Check the docker configurations to see if there is a proxy misconfiguration. Best approach is to avoid proxy; if proxy is required to get online, check with docker documentation on specifying proxies: https://docs.docker.com/network/proxy/

## bom-uploader appears to hang?

Ensure there is no proxy between the uploader client vm and the minio server.
Remove/unset http_proxy env variable if its set.

## Downloading vmware bits
Ensure the vware creds are correctly filled in the `bom/bom*.yml` file and you are able to download the `apnex/vmw-cli` docker image. The bom-mgmt tool would then use the docker image to download VMware NSX-T install bits.

## DNS Setup

The setup require DNS configuration to be updated to reflect the new dns names.

| Component | Prefix    | Domain       |      Sample  FQDN          | IP   | Notes      |
|-----------|-----------|--------------|----------------------|-------|---------------------|
| NSX Mgr   | nsx-t-mgr | ((dnsdomain)) | nsx-t-mgr.corp.local    | ((nsx_t_manager_ip)) | This would be used for the self-signed certs generated and registered against NSX-Mgr. |
| Ops Mgr   | opsmgr    | ((dnsdomain)) | opsmgr.corp.local    | ((nsx_t_nat_rules_opsman_ip)) | Ops Mgr request would be routed to the external `nsx_t_nat_rules_opsman_ip` ip provided for Ops Mgr |
| PKS Controller   | *.pks | ((dnsdomain)) | *.pks.corp.local    | ((pks_api_ip)) | Any `api.pks.corp.local` or `uaa.pks.corp.local` would be routed to the preconfigured external `pks_api_ip` ip address |
| Harbor   | harbor | ((dnsdomain)) | harbor.corp.local    | ((harbor_app_external_ip)) | `harbor.corp.local` would be routed to the external `harbor_app_external_ip` ip specified. |
| PKS-Cluster-Name   | some-cluster-prefix | ((dnsdomain)) | cluster1.pks.corp.local    | ((exposed_external_ip)) | `cluster1.pks.corp.local` would be routed to the external exposed_external_ip specified. |
## Using IPs instead of using DNS Names

The default setup config would use DNS names for the above mentioned resources (NSX Mgr, Ops Mgr, PKS Controller, Harbor). DNS is also required for the PKS UAA Client creation (uses uaa or api.<domain-name>) and Clusters. So, best to avoid using IPs and configure setup to use the DNS names.

## Adding additional T1 Routers or Logical Switches
  * Modify the final generated parameters to specify additional T1 routers or switches and rerun add-routers.

## Adding additional T0 Routers
  * Only one T0 Router can be created during a run of the pipeline. But additional T0Routers can be added by  modifying the parameters and rerunning the add-routers and config-nsx-t-extras jobs.
    * Create a new copy or edit the parameters to modify the T0Router definition.
    * Edit T0Router references across T1 Routers as well as any tags that should be used to identify a specific T0Router.
    * Add or edit any additional ip blocks or pools, nats, lbrs
    * Register parameters with the pipeline
    * Rerun add-routers followed by config-nsx-t-extras job group

## Static Routing for NSX-T T0 Router
Please refer to the [Static Routing Setup](./static-routing-setup.md) for details on the static routing.

## More details on NSX-T Install pipeline
Please refer to the [nsx-t-gen FAQs](https://github.com/sparameswaran/nsx-t-gen/blob/master/docs/faqs.md) for additional details on the various configurations possible.

## NSX-T OVA deployment fails
If the NSX-T Management vm creation fails during OVA deployment with following messages, this can be indicate of memory issues.

```
[21-08-18 21:54:36] Uploading nsx-edge.vmdk... OK
[21-08-18 21:54:36] Powering on VM...
govc: DRS cannot find a host to power on or migrate the virtual machine.
failed
```
Shutdown and remove the NSX-T Controllers or Edge instances. Mgr is just a singleton instance not taking large memory and should be okay. Modify the following parameter and rerun the install pipeline so the VMs are brought back up with memory reservation turned OFF.
```
nsx_t_keep_reservation: false # true for Prod setup
```
Ensure the property is saved in `params/nsx-t-for-canned-pks-params.yml`, rerun the param-merger to get the updated property reflected properly before re-running the pipeline again. Having reservation ON can starve the underlying infrastructure if its already overloaded or has lower memory.

## PKS Cluster creation fails
If the pks cluster creation fails with following error, it might be due to overload on the underlying infrastructure. Change the PKS plan to bring up one worker at a time from default 3 or 5 workers.
```
nsx-t-osb-proxy/pks-nsx-t-osb-proxy.stderr.log:time=“2018-08-24T14:18:10Z” level=warning msg=“There is no resource for cluster f453ef9a-bbc4-4834-8db8-604641b0f5d8\n” pks-networking=CollectResources
```
