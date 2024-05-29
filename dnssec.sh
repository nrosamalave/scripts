#!/bin/bash

# Prompt the user to choose between nameserver set 1 or 2
echo "Choose the nameserver set to use (1 or 2):"
read -p "Enter 1 or 2: " nameserver_choice

# Set the nameserver based on user choice
if [ "$nameserver_choice" == "1" ]; then
  nameserver="ns10.digicertdns.com"
elif [ "$nameserver_choice" == "2" ]; then
  nameserver="ns20.digicertdns.com"
else
  echo "Invalid choice. Exiting."
  exit 1
fi

# Get the list of domain names from the user.
echo "Enter a list of domain names, separated by spaces:"
read domain_names

# Loop through the list of domain names.
for domain in $domain_names; do
  echo "Domain: $domain"
  # Run a dig against the DNSKEY and grep the CDS records for the domain.
  dig @$nameserver $domain in cds +nocomments +noauthority +noadditional | grep "CDS" | while read -r line; do
    # Parse the CDS record
    key_id=$(echo "$line" | awk '{print $5}')
    algorithm=$(echo "$line" | awk '{print $6}')
    digest_type=$(echo "$line" | awk '{print $7}')
    digest=$(echo "$line" | awk '{print $8}')

    # Only output if the Key ID is not empty
    if [[ -n "$key_id" ]]; then
      echo "Key ID: $key_id"
      echo "Algorithm: $algorithm"
      echo "Digest Type: $digest_type"
      echo "Digest: $digest"
      echo
    fi
  done
done
