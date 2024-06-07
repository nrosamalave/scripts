import requests
import hashlib
import hmac
from datetime import datetime

# Replace these variables with your actual API credentials
api_key = 'ENTER API KEY'
api_secret = 'ENTER SECREY KEY'

# Generate HMAC signature
def generate_hmac(api_secret, request_date):
    date_bytes = request_date.encode('utf-8')
    secret_bytes = api_secret.encode('utf-8')
    hmac_obj = hmac.new(secret_bytes, date_bytes, hashlib.sha1)
    hmac_signature = hmac_obj.hexdigest()
    return hmac_signature

# Get the current date and time in the format used by Postman
request_date = datetime.utcnow().strftime("%a, %d %b %Y %H:%M:%S GMT")

# Generate HMAC signature using the request date
hmac_signature = generate_hmac(api_secret, request_date)

# Define the headers with the authentication information
headers = {
    'x-dnsme-apiKey': api_key,
    'x-dnsme-requestDate': request_date,
    'x-dnsme-hmac': hmac_signature
}

# Make the API call
response = requests.get("https://api.dnsmadeeasy.com/V2.0/dns/managed/", headers=headers)

# Parse the JSON response into a dictionary
data = response.json()

# Check if the request was successful
if response.status_code == 200:
    # Extract the domain names from the response
    domains = [domain['name'] for domain in data['data']]
    print(domains)
    
    # Write domain names to a text file
    with open('domain_names.txt', 'w') as file:
        for domain in domains:
            file.write(domain + '\n')
else:
    print(f"Failed to retrieve data: {response.status_code}")
    print(response.text)

