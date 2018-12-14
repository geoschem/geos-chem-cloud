# /bin/bash
# Tested on Amazon Linux 2 AMI ami-009d6802948d06e52
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

sudo yum update -y
sudo yum install -y git tmux emacs  # basic stuff, unrelated to Docker

sudo amazon-linux-extras install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Need to log out and log back in again to pick up the new docker group permissions. 