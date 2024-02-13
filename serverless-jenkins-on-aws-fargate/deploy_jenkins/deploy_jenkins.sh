#!/usr/bin/bash

set -e

source vars.sh


# Start from a clean slate
rm -rf .terraform

terraform init \
    -backend=true \
    -backend-config key="${TF_STATE_OBJECT_KEY}" \
    -backend-config bucket="${TF_STATE_BUCKET}" \
    -backend-config dynamodb_table="${TF_LOCK_DB}"

if [ "$1" == "plan" ]; then
    terraform plan \
        -lock=false \
        -input=false

elif [ "$1" == "apply" ]; then
    terraform plan \
	-lock=false \
        -input=false \
        -out=tf.plan

    terraform apply \
        -input=false \
        -auto-approve=true \
        -lock=true \
        tf.plan

elif [ "$1" == "destroy" ]; then
    terraform destroy \
        -input=false \
        -auto-approve=true \
        -lock=true

else
    echo "Invalid argument. Usage: $0 <plan|apply|destroy>"
    exit 1
fi
