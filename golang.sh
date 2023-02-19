# https://go.dev/doc/install
export GOBIN=go1.20.1.linux-amd64.tar.gz
curl -sL https://go.dev/dl/$GOBIN > $GOBIN
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf $GOBIN
echo 'PATH=$PATH:/usr/local/go/bin' >> $HOME/.bashrc

bash -c "go version" 

