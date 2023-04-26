packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-node-nginx"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  /* post-processor "shell-local" {     
    inline = [
    "aws ec2 run-instances --image-id {{.ImageId}} --count 1 --instance-type t2.micro --key-name packer-keys --security-group-ids sg-03b79f83ba62f42e7"
    ]    
  } */

  provisioner "shell" {
    inline = [
      "sudo mkdir /home/ubuntu/node-app",
      "sudo chmod 777 /home/ubuntu/node-app"
    ]
  }

  provisioner "file" {
    source      = "./hello.js"
    destination = "/home/ubuntu/node-app/hello.js"
  }

  provisioner "shell" {
    script = "./install.sh"
  }
}


