!/bin/bash
# Get the list of domain names from the user.
echo "Enter a list of domain names, separated by spaces:"
read domain_names
# Set the nameserver to use.
nameserver="208.94.148.159"
# Loop through the list of domain names.
for domain in $domain_names; do
  # Run a dig against the DNSKEY and grep the KSK for the domain.
  dig @$nameserver $domain dnskey  +nocomments +noauthority +noadditional | grep "257"
done