# gcp_week10_hw

---

# Q & A

## DNS and SSL/TLS
1. Explain what the traceroute and dig commands do. Compare and contrast. 

- Both commands show you how to reach, connect, and to get the happenings of trace route and DNS. When making the commands for both, you’re able to see where the information is going, what is returned, and how long it took to respond to the commands. The differences are, dig operates for DNS, to let you know if a DNS name is resolved correctly, and traceroute is for networking, it will tell let you know if your IP is reachable. Traceroute will tell you which server is causing the problem, and you use TTL (time-to-live) to make sure that what you send out has a destination, or it will loop.

2. What are the 3 or 4 most common DNS records and what are their use cases? 
- A Record or Address record: The most common DNS record. It resolves domain names to IP addresses with IPv4 addresses. When you type in a domain name in the web browser, it resolves a domain name to an IP address

- AAAA Record: These records resolve domain names to IP addresses, by using IPv6 IP addresses.

- CNAME or Canonical Name: This record resolves a domain or subdomain name to another domain name. These are used when a website has different servers running on the same server and are using the same IP address.

- MX or Mail Exchanger Record: A record used for email. It points to the server where emails should be delivered for that domain name. There are 2 servers, depending on the priority number. When the primary server is overwhelmed then that is when the second server is used.

- NS or Name Server Record: Provides the name of the authoritative name server within a domain. It contains all DNS records necessary for users to find a computer or server on a local network or on the Internet. 


3. Give an overview of the steps in a TLS handshake. 
- The server checks to see if there is anything new created on port 443 that it will be able to connect to.
- The human, person, or whatever term you want to use, makes sure that it has something connected to port 443 so that it can start the process to exchange information with the server. Then the person sends message to the server on port 443 to show the server that the person has port 443 ready.
- After the message is sent to the server, the server sends the message back to the person who sent out the initial message, showing that there is something connected to port 443
- The certificate is used, by whoever the sender is, and confirms the server is legit by getting cryptographic keys from a Certificate Authority
- The sender then gets back a the set of cryptographic keys from the server, proving that the server has what the sender has.
- Now both have the same keys, they both now have it is needed for the encrypted messages to flow back and forth with one another.


4. How does an SSL/TLS cert know what domain it belongs to?
- SSL and TLS are used interchangeably at this point. The name of the website will be inserted into the SSL/TLS certs data, the website name that the person, or sender, has chosen for the website. What that is called is a Subject Alternative Name (SAN), and that is what is is in the data of the SSL/TLS certificate



5. What is a certificate authority? 
- A third party client, or a trusted organization that approves TLS certificates and verifies that it is owned by the user, and it approves the use of browsing the internet with HTTPS.


## Load Balancers:

6. How do application load balancers in GCP offload (decrypt) SSL? What part of the load balancer does this? 

- This is done by terminating the connection of the load balancer. This is done by the frontend of the load balancer.

7. Are there use cases to have in flight encryption from the backend service to the backend itself? 
- Yes. It’s used to make sure that data is protected from anyone that attempts to mess with the data being sent in transition. It is used by healthcare facilities and finance institutions, making sure that information is heavily protected from any or anything that isn’t meant to have it.

## Cloud Domain/DNS: 

8. Can multiple domains end up pointing to the same LB? 

- Yes they can. This is done to control cost, and/or to make sure you can route different, but similar, hostnames that are on backend servers through the same load balancer.


9. In the context of Cloud DNS, what are zones?

- Cloud DNS zones are part of DNS namespaces used to host and organize DNS records. There are private and public zones. Public zone being visible to the internet and one can publish their services to the internet. Private zone is anything that cannot be passed through on the public internet.