#!/usr/bin/env bash

set -x

# following lines are useful if using a Vagrant base box other than the badarsebard Splunk boxes
#wget -q -O splunk.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.3.2&product=splunk&filename=splunk-7.3.2-c60db69f8e32-linux-2.6-amd64.deb&wget=true'
#sudo dpkg -i splunk.deb

# set timezone and some conveniences
sudo timedatectl set-timezone America/New_York
sudo -u splunk cp /home/vagrant/.bashrc ${SPLUNK_HOME}/.bashrc
sudo -u splunk cp /home/vagrant/.profile ${SPLUNK_HOME}/.profile
echo "alias splunk=${SPLUNK_BIN}" | sudo tee -a ${SPLUNK_HOME}/.bashrc > /dev/null
echo "splunk:${SPLUNK_PASS}" | sudo chpasswd

# configure initial Splunk settings
cat << EOF | sudo -u splunk tee -a ${SPLUNK_HOME}/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = ${SPLUNK_PASS}
EOF

# set Splunk logging levels
sudo -u splunk tee -a ${SPLUNK_HOME}/etc/log-local.cfg << 'EOF'
EOF

# this is a trick for setting the Splunk Python as the remote interpreter for JetBrains while maintaining the environment set by the splunk cmd command
sudo -u splunk tee -a ${SPLUNK_HOME}/bin/python_splunk.sh << 'EOF'
#!/bin/bash
"$(dirname "$0")/splunk" cmd python "$@"
EOF
sudo -u splunk chmod +x ${SPLUNK_HOME}/bin/python_splunk.sh

# remove first login warning
sudo -u splunk touch ${SPLUNK_HOME}/etc/.ui_login

# initial Splunk start with license accept
sudo -i -u splunk ${SPLUNK_BIN} start --accept-license --no-prompt
