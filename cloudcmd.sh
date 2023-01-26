bash ./nodejs.sh

npm i cloudcmd -g

EXEC="cloudcmd --port 85"

echo """
# Contents of /etc/systemd/system/myservice.service
[Unit]
Description=My Service
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=${EXEC}

[Install]
WantedBy=multi-user.target
""" > /etc/systemd/system/cloudcmd.service