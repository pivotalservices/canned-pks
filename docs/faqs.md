# FAQs

* Pre-reqs

  1) Online Access
    The Bill of Materials download step needs online access to:
    . Download the various tools (fly, bom-mgmt, mc)
    . Download the actual install bits.
  2) Docker and python setup on the Jumpbox machine
  3) DNS Setup access

* bom-downloader appears to hang or fail?

Ensure there is no proxy between the downloader client vm and Internet.
Remove/unset http_proxy env variable if its set. Also, downloading the vmware bits requires docker install (again with no proxy). Check the docker configurations to see if there is a proxy misconfiguration. Simplest and best is to avoid proxy; if proxy is required to go out, check with docker documentation on specifying proxies: https://docs.docker.com/network/proxy/

* bom-uploader appears to hang?

Ensure there is no proxy between the uploader client vm and the minio server.
Remove/unset http_proxy env variable if its set.

* Downloading vmware bits
Ensure the vwware creds are correctly filled in the `tools/setup.sh` file and you are able to download the `apnex/vmw-cli` docker image. The bom-mgmt tool would then use the docker image to download nsx-t bits.

* DNS Setup

The setup require DNS configuration to be updated to reflect the new dns names.

| Component | Prefix    | Domain       |      Sample  FQDN          | IP   | Notes      |
|-----------|-----------|--------------|----------------------|-------|---------------------|
| NSX Mgr   | nsx-t-mgr | ((dnsdomain)) | nsx-t-mgr.corp.local    | ((nsx_t_manager_ip)) | This would be used for the self-signed certs generated and registered against NSX-Mgr. |
| Ops Mgr   | opsmgr    | ((dnsdomain)) | opsmgr.corp.local    | ((nsx_t_nat_rules_opsman_ip)) | Ops Mgr request would be routed to the external `nsx_t_nat_rules_opsman_ip` ip provided for Ops Mgr |
| PKS Controller   | *.pks | ((dnsdomain)) | *.pks.corp.local    | ((pks_api_ip)) | Any `api.pks.corp.local` or `uaa.pks.corp.local` would be routed to the preconfigured external `pks_api_ip` ip address |
| Harbor   | harbor | ((dnsdomain)) | harbor.corp.local    | ((harbor_app_external_ip)) | `harbor.corp.local` would be routed to the external `harbor_app_external_ip` ip specified. |

* Using IPs instead of using DNS Names

The default setup config would use DNS names for the above mentioned resources (NSX Mgr, Ops Mgr, PKS Controller, Harbor). DNS is also required for the PKS UAA Client creation and Clusters. So, better to avoid using IPs and use the DNS names.

* Adding additional T1 Routers or Logical Switches
  * Modify the final generated parameters to specify additional T1 routers or switches and rerun add-routers.

* Adding additional T0 Routers
  * Only one T0 Router can be created during a run of the pipeline. But additional T0Routers can be added by  modifying the parameters and rerunning the add-routers and config-nsx-t-extras jobs.
    * Create a new copy or edit the parameters to modify the T0Router definition.
    * Edit T0Router references across T1 Routers as well as any tags that should be used to identify a specific T0Router.
    * Add or edit any additional ip blocks or pools, nats, lbrs
    * Register parameters with the pipeline
    * Rerun add-routers followed by config-nsx-t-extras job group

* More details on NSX-T Install pipeline
Please refer to the [nsx-t-gen FAQs](https://github.com/sparameswaran/nsx-t-gen/blob/master/docs/faqs.md) for additional details on the various configurations possible.
