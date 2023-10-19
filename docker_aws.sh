DOCKER_COMPOSE_VERSION=1.22.0

# https://gist.github.com/npearce/6f3c7826c7499587f00957fee62f8ee9
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
exec sg docker

sudo chkconfig docker on
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_CONPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

