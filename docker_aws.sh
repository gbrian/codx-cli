# https://gist.github.com/npearce/6f3c7826c7499587f00957fee62f8ee9
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
exec sg docker

sudo chkconfig docker on


# https://stackoverflow.com/a/72156137/1302743
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
