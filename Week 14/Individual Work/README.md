# gcp_week14_hw

---

# Differences between HA VPN and NCC

## What they are

```
- First, it must be known what each function is.

- HA VPN connects to tow specific endpoints to one another. It can a GCP VPC to an on-premises, or GCP to AWS. Basically one cloud provider to another (public to public, private to public, public to on-prem, etc). This is done over the public internet using IPSec. The main thing this accomplishes is extending your network to GCP

- NCC is a Network Connectivity Center. To me, an NCC is just a Transit Gateway, as oppose to VPC peering. You are able to manage and connect multiple network resources through a central hub. This accomplishes managing connectivity between many sites at scale. 
```

## Similarities

```
- They both operate within GCP’s network infrastructure and managed through the GCP console

- Both can use HA VPN tunnels as their their transport

- The both support hybrid connectivity (Public to on-premises)

- Both integrate with Cloud Router for route advertisements and management

- Both support encrypted traffic in transit

- Both are regional resources that can be deployed across multiple GCP regions
```

## Differences
```
- HA VPN’s main purpose is to encrypt tunnels between to endpoints. NCC connects to many sites and networks

- HA VPN is point-to-point. NCC is hub-and-spoke

- HA VPN is one peer per tunnel pair. NCC is many sites through one hub

- HA VPN requires a shared VPC for site-to-site routing. NCC has all networking connecting to each other through the hub

- HA VPN uses IPSec over the internet for encryption. 
```

# The use cases of HA VPN vs NCC

## HA VPN
```
- Use when you have one or a small number of on-premises sites connecting to GCP
- You want the simplest possible setup with the lowest overhead
```

## NCC
```
- There are many branch offices or data centers needing to connect
- You need on-premises sites to route to each other through GCP
- You want centralized visibility and management of all your hybrid connections to one place
```

# Network Intelligence Center
```
This is GCP’s network observability and diagnostic platform. It is used to understand, troubleshoot, monitor, and verify your network configuration and traffic behavior across your GCP network.
```

## Network Topology: 
A visual graph of your GCP network. 

```
- It audits your network to confirm if your infrastructure matches what was designed
- You’ll be able to identify unexpected traffic paths or connections between resources
- Knowing there are any unused networking resources
```

## Connectivity Test: 
Simulates a network path between a source and destination without sending real traffic. 

```
- Finding out why one VM is unable to connect to another VM without having to SSH into  them
- Making sure that firewall rules are configured properly before deployment
- Able to test VPN tunnels, how they are able to be reached, between GCP and on-premises resources
- Can confirm that a load balancer health check is clear before the load balancer created
- Making sure a firewall rule has the intended effect
```

## Performance Dashboard: 
Shows inter-region and inter-zone metrics across your network. 

```
- Being able to choose which region in GCP you want to deploy to based on latency and then to other regions that are being used
- Troubleshooting to find out if an issue is caused by your infrastructure or by GCP
- Monitor latency over time and be able to detect if anything is failing, or falling apart before it is reported
- Plan multi-region architectures, and knowing where the latency is going to be measured between the regions that you want to use before using them
```


## Firewall Insights: 
Analyzes your VPC firewall rules and surfaces intelligence about them. Which rules are never hit, which rules shadow other tules and which rules are overly permissive relative to actual traffic patterns

```
- Find firewall rules that allow traffic but are not used
- Know which rules are more important than others, and what makes a more specific rule unreachable
- Replace overly broad allow rules with tighter rules based on traffic by those rules that have been observed
- Demonstrate which firewall rules are actively used and intentionally scoped
```

## Network Analyzer: 
Continuously scans your network configuration and automatically surfaces potential misconfigurations, best practice violations, and suboptimal settings without the user asking it to do so. 

```
- Checks your misconfigurations before outages can occur, such as asymmetric routes, misconfigured BGP sessions, and broken VPN tunnels
- Knowing which VMs without external IPs that still have firewall rules allowing inbound traffic
- Detecting NAT gateways with insufficient IP allocations that will cause connection failures
```


# Resources:

https://docs.cloud.google.com/network-connectivity/docs/network-connectivity-center/concepts/overview

https://docs.cloud.google.com/network-connectivity/docs/network-connectivity-center/concepts/overview#vpn-spokes

https://docs.cloud.google.com/network-intelligence-center/docs/overview