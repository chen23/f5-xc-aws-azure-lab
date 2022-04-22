#!/bin/bash
#
# Check that site is online before creating workload resources
#

env
private_ip=$(echo $TF_VAR_xcmesh|jq .private_ips[0]);

    json=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/aws_tgw_sites/$TF_VAR_projectPrefix-tgw-1  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s)
    echo $json |jq . -c > site-config.json;
    cat site-config.json | sed -e "s/\"site_to_site_tunnel_ip\":\"\"/\"site_to_site_tunnel_ip\":$private_ip/g" > site-config-modified.json;
    echo $json | jq .spec.site_to_site_tunnel_ip ;
    registration=$(curl --location --request GET $VOLT_API_URL/register/namespaces/system/registrations_by_site/$TF_VAR_projectPrefix-tgw-1 -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s)
    echo $registration |jq .items[0].object.spec.gc_spec.infra.interfaces.fabric.addr;
    status=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/sites/$TF_VAR_projectPrefix-tgw-1 -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s);
    echo $status |jq .status[0];
    # update with private IP
    curl --location --request PUT $VOLT_API_URL/config/namespaces/system/aws_tgw_sites/$TF_VAR_projectPrefix-tgw-1  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -d @./site-config-modified.json

    private_ip2=$(echo $TF_VAR_xcmesh2|jq .private_ips[0]);
    json=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/aws_tgw_sites/$TF_VAR_projectPrefix-tgw-2  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s)
    echo $json |jq . -c > site-config.json;
    cat site-config.json | sed -e "s/\"site_to_site_tunnel_ip\":\"\"/\"site_to_site_tunnel_ip\":$private_ip2/g" > site-config-modified.json;
    echo $json | jq .spec.site_to_site_tunnel_ip ;
    registration=$(curl --location --request GET $VOLT_API_URL/register/namespaces/system/registrations_by_site/$TF_VAR_projectPrefix-tgw-2 -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s)
    echo $registration |jq .items[0].object.spec.gc_spec.infra.interfaces.fabric.addr;
    status=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/sites/$TF_VAR_projectPrefix-tgw-2 -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s);
    echo $status |jq .status[0];
    # update with private IP
    curl --location --request PUT $VOLT_API_URL/config/namespaces/system/aws_tgw_sites/$TF_VAR_projectPrefix-tgw-2  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -d @./site-config-modified.json
    

    echo $private_ip;
    echo $private_ip2;    
    
