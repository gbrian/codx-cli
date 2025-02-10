#!/bin/bash
USER_NAME=$1
USER_PWD=$2
# create ssh user
# quietly add a user without password
adduser --quiet --disabled-password --shell /bin/bash --home /home/${USER_NAME} --gecos "${USER_NAME}" ${USER_NAME}
# set password
echo "${USER_NAME}:${USER_PWD}" | chpasswd
usermod -aG sudo ${USER_NAME}


git clone https://github.com/billchurch/webssh2
cd webssh2
git checkout current

cd app
npm install --production

echo "#!/bin/bash
cd $PWD
npm start" > /usr/bin/webssh2
chmod +x /usr/bin/webssh2

echo "Remote SSH2 installed. Use 'webssh2' to run it"
