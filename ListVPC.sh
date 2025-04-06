#!/bin/bash
REGIONS=$@
for REGION in $REGIONS; do
    echo "#--------------${REGION}-------------------#"
    aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId"
done