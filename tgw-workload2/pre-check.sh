#!/bin/bash
#
# Check that site is online before creating workload resources
#

site_state=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/aws_tgw_sites/$TF_VAR_projectPrefix-tgw-2  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s  |jq -r .spec.site_state)
if [ "$site_state" = "ONLINE" ]; then
   echo "ONLINE: TGW site is online.  Safe to proceed."
   exit 0
else
    echo $site_state
    echo "OFFLINE: wait for TGW Site to be ONLINE before proceeding"
    exit 1
fi    
