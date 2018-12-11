# /bin/bash
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user