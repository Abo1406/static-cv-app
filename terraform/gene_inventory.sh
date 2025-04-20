#!/bin/bash

# Load Terraform state from local file
STATE_FILE="terraform/environments/terraform.tfstate"

# Extract droplet IPs or app_ips from outputs using jq
HOSTS=$(jq -r '.modules[1].outputs.app_ips.value[]?' "$STATE_FILE")

# Create inventory in JSON format
{
  echo "{"
  echo "  \"all\": {"
  echo "    \"hosts\": ["
  for ip in $HOSTS; do
    echo "      \"$ip\"," 
  done | sed '$s/,$//'
  echo "    ]"
  echo "  }"
  echo "}"
}
