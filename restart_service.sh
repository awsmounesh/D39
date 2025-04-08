#!/bin/bash
set +x
if [ $# -gt 0 ]; then
    for REGION in $@; do
        echo "[----$REGION----]"
        aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" -r
    done
else
    echo "you have given $# parameters to this script, please provide arg Eg.us-east-1."
fi
