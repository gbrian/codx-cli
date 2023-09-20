# THANKS TO: https://www.cyberciti.biz/faq/how-to-install-docker-on-amazon-linux-2/
sudo yum update
# Search for Docker package:
sudo yum install -y docker

# Need docker-compose too? Try any one of the following command:
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose

# Enable docker service at AMI boot time:
sudo systemctl enable docker.service
# Start the Docker service:
sudo systemctl start docker.service

# Add group membership for the default ec2-user so you can run all docker commands without using the sudo command:
sudo usermod -a -G docker ec2-user
id ec2-user
# Reload a Linux user's group assignments to docker w/o logout
newgrp docker
