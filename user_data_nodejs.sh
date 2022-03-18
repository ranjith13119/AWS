#!/bin/bash -ex
# output user data logs into a separate file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# download nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# source nvm
. /.nvm/nvm.sh
# install node
nvm install node
#export NVM dir
export NVM_DIR="/.nvm"	
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"	
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
#upgrade yum
sudo yum upgrade
#install git
sudo yum install git -y
cd /home/ec2-user
# get source code from githubt
git clone https://github.com/ranjith13119/AWS
#get in project dir
cd AWS
# Git checkout to the branch 
git checkout rds-ec2
#give permission
sudo chmod -R 755 .
#install node module
npm install
# start the app
MYSQL_HOST="" MYSQL_USER="admin" MYSQL_PASSWORD='"admin#123'" MYSQL_DATABASE='nodedb' node server.js > app.out.log 2> app.err.log < /dev/null &