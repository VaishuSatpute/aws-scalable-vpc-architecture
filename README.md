# AWS Scalable VPC Architecture

An AWS networking practice project focused on designing a modular, highly available VPC architecture.

## Architecture

- Bastion VPC: `192.168.0.0/16`
- Application VPC: `172.32.0.0/16`
- Public and private subnets across multiple Availability Zones
- Internet Gateway for public connectivity
- NAT Gateway for private-subnet outbound access
- Transit Gateway for private communication between VPCs
- Application Load Balancer
- Auto Scaling Group
- EC2 Launch Template
- Route 53
- S3
- CloudWatch and VPC Flow Logs
- AWS Systems Manager

## What I Practiced

1. VPC and subnet design
2. Public vs private routing
3. NAT Gateway and Internet Gateway
4. Transit Gateway connectivity
5. Bastion-host access
6. ALB + Target Group + Auto Scaling
7. IAM roles and least-privilege access
8. CloudWatch monitoring and VPC Flow Logs

## Deployment Status

This repository is an infrastructure learning/practice implementation. AWS resources are not claimed as currently deployed.
