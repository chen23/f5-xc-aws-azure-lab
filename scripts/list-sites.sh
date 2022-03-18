#!/bin/bash
projectPrefix="mw"

function get-nodes {
  region=$1
  site="$projectPrefix-tgw-$2"
  echo "$site ($region):"
  aws ec2 describe-instances --region $region \
      --filters \
      Name=tag:ves-io-site-name,Values=$site \
      Name=instance-state-name,Values=running \
      --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PublicIpAddress,PrivateIpAddress]" \
      --output=text | sort
          echo ""
}

get-nodes eu-north-1 1
get-nodes us-west-2 2

echo "$projectPrefix-azure-1:"
cd azure-site && terragrunt show|grep _ip_address
