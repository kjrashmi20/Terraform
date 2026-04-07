#!/bin/bash

echo "Initializing Terraform..."
terraform init -input=false

echo "Running Terraform plan..."
terraform plan -detailed-exitcode -out=tfplan

exit_code=$?

if [ $exit_code -eq 0 ]; then
    echo "No drift detected"
elif [ $exit_code -eq 2 ]; then
    echo "Drift detected!"

    terraform show -json tfplan > plan.json

    echo "Drift details:"
    jq '.resource_changes[]?.change.actions' plan.json

    exit 2
else
    echo "Terraform error"
    exit 1
fi
