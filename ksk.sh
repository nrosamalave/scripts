#!/bin/bash

# Prompt the user to choose between nameserver 1 or 2
echo "Choose the nameserver to use:"
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

# Get the list of domain names from the user
echo "Enter a list of domain names, separated by spaces:"
read domain_names

# Loop through the list of domain names
for domain in $domain_names; do
  echo "Domain: $domain"
  # Run a dig against the DNSKEY and grep the KSK (key signing key) for the domain
  dig @$nameserver $domain dnskey +nocomments +noauthority +noadditional | grep "257"
  echo
done
