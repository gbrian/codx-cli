# Dependencies
codx nodejs

# https://github.com/ChrisCindy/node-web-console/blob/master/README.md
git clone https://github.com/ChrisCindy/node-web-console.git
cd node-web-console

# instal dependencies 
npm install

## build and minify client side scripts and stylesheets
npm run client:build

## disbale extra login
sed -i 's/noLogin: false/noLogin: true/g' config/index.js

## start the server with pm2 
npm run prod &
