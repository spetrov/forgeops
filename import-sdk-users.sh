#!/usr/bin/env bash

ADMIN_PASSWORD=$(kubectl -n default get secret ds-passwords -o jsonpath="{.data.dirmanager\.pw}" | base64 --decode)

echo "Import users using import-ldif"
kubectl cp users.ldif ds-idrepo-0:/opt/opendj/data/var/sdk-users.ldif
kubectl exec ds-idrepo-0 -it -- import-ldif --clearBackend --backendId amIdentityStore --ldifFile /opt/opendj/data/var/sdk-users.ldif \
   --skipFile /tmp/skip  --rejectFile /tmp/rejects \
   --noPropertiesFile --port 4444 --trustAll \
   --bindDN "uid=admin" --bindPassword $ADMIN_PASSWORD --clearBackend --overwrite