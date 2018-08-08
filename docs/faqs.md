# FAQs

* bom-uploader appears to hang?

Ensure there is no proxy beteween the uploader client vm and the minio server.
Remove/unset http_proxy env variable if its set.

* Downloading vmware bits
Ensure the creds are correctly filled in the bom* file and you are able to down the `apnex/myvmw` docker image. That would then use the docker image to download nsx-t bits.
