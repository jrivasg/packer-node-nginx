#!/bin/bash

AMI_ID=$(jq -r '.builds[-1].artifact_id' ./packer-manifest.json)
IMAGE_ID=$(echo $AMI_ID | cut -d ":" -f 2)

aws ec2 run-instances --image-id $IMAGE_ID --count 1 --security-group-ids sg-03b79f83ba62f42e7 --key-name packer-keys --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=node-nginx-instance}]'
