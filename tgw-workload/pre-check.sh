#!/bin/bash
#
# Check that site is online before creating workload resources
#

for x in `seq 1 120`; do
    site_state=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/aws_tgw_sites/$TF_VAR_projectPrefix-tgw-1  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s  |jq -r .spec.site_state)
if [ "$site_state" = "ONLINE" ]; then
   echo "ONLINE: AWS TGW site is online.  Safe to proceed. waited $x minutes"
   exit 0
else
    echo $site_state
    echo "OFFLINE: wait for AWS TGW Site to be ONLINE before proceeding.  Waiting $x minutes"
    #exit 1
fi    
sleep 60;
done;
echo $site_state
echo "OFFLINE: wait for AWS TGW Site to be ONLINE before proceeding; timed out after 120 minutes"
exit 1;
