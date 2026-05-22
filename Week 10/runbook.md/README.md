---

# Runbook (### Anti-Drunk Engineer)

## Troubleshooting

- Find the errors of this

- Checking out the VM Instance (homework-vm), there is no External IP Address. You are also unable to use SSH
![- No External IP. No SSH](screenshots/1.png)

- The VM Instance is also not running. 
![- VM Instance not running](screenshots/2.png)

- Getting the VM Instance to Run
![- VM Instance now running](screenshots/3.png)

- Click into the Instance, click onto Edit, scroll down to Networking, click on Network Interfaces, at External IPv4 address click the box and choose Ephemeral.
![- Before](screenshots/4a.png)
![- After](screenshots/4b.png)

- External IP is up, but you're still unable to access it on the internet. 
![- Before](screenshots/5a.png)
![- After](screenshots/5b.png)

- Back to edit the VM Instance, scroll down to Firewalls and choose Allow HTTP traffic
![- After](screenshots/6.png)

- Unable to SSH into the Instance as well. This is a Firewall issue
![- No SSH](screenshots/7.png)

- Go to the VPC (homework-vpc) and check the Firewall Rules. There is a deny-all rule for the VPC with a Priority of 0.
- Delete this Firewall Rule
![- Deny-All](screenshots/8a.png)
![- Deny-All Deleted](screenshots/8b.png)

- Checking all of the other Firewall Rules, in the SSH Firewall rule IPv4, the address is 1.2.3.4/32, while the HTTP Firewall rule is 0.0.0.0/0. We must change the Firewall Rule for SSH rule.
![- SSH 1](screenshots/9a.png)
![- SSH 2](screenshots/9b.png)
![- SSH 3](screenshots/9c.png)

- Next, make sure the HTTP Firewall Rules are aligned. Make sure they both have the same IP ranges and are on the same port (80)
![- HTTP 1](screenshots/10a.png)
![- HTTP 2](screenshots/10b.png)

- Check the SSH connection for the VM Instance. 
![- SSH Complete](screenshots/11.png)

- Still unable to connect to the internet. Check the HTTP Firewall Rules again. Once you see that everything is fine, supposedly, you may have to check the routes. 

- In VPC Network, on your left (click the three lines on the left if you have to), click on Routes, once on that page click Route Management. Your Route is connected to the default VPC for GCP, not homework-vpc
![- No Route](screenshots/12.png)

- Go back to Routes, click on Route Management (In case you're not there anymore), click Create Route. Choose a name, a description, under network choose homework-vpc, for Destination IPv4 range: 0.0.0.0/0
![- Now we got Routes 1](screenshots/13a.png)
![- Now we got Routes 2](screenshots/13b.png)

- Now go back to your VM Instance, copy and paste your External IP into your web browser. Check the results
![- VM Fixed...yay](screenshots/13b.png)

- Now that it has been fixed, you can tear down the VM Instance and then the VPC (In that order).