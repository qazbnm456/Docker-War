#!/bin/bash

#    The Star And Thank Author License (SATA)
#
#    Copyright (c) 2014-2016 Lobsiinvok (lobsiinvok@tdohacker.org)
#
#    Project Url: https://github.com/qazbnm456/Docker-War
#
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in
#    all copies or substantial portions of the Software.
#
#    And wait, the most important, you shall star/+1/like the project(s) in project url
#    section above first, and then thank the author(s) in Copyright section.
#
#    Here are some suggested ways:
#
#     - Email the authors a thank-you letter, and make friends with him/her/them.
#     - Report bugs or issues.
#     - Tell friends what a wonderful project this is.
#     - And, sure, you can just express thanks in your mind without telling the world.
#
#    Contributors of this project by forking have the option to add his/her name and
#    forked project url at copyright and project url sections, but shall not delete
#    or modify anything else in these two sections.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#    THE SOFTWARE.

# #########################
#     value
# #########################
set -e

if [ $EUID != 0 ]; then
	echo "This script must be run as root."
	echo -e "Usage: sudo ./setup.sh"
	exit $exit_code
	exit 1
fi

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "This script help you to setup and initialize the Docker-War project.";
echo -e "Please fill out the form before heading to next step."

read -p "Server domain: " domain
test -z ${domain} && echo "You MUST input a domain." && exit 0

read -p "Project name: " project
test -z ${project} && echo "You MUST input a name." && exit 0

read -p "Secret key(At least 30 characters and all random): " secret
test -z ${secret} && echo "You MUST input a secret key." && exit 0

sed -i 's/domain.com/'${domain}'/g' playground.sh
sed -i 's/domain.com/'${domain}'/g' docker-compose.yml
sed -i 's/project_name/'${project}'/g' config.sh
sed -i 's/project_name/'${project}'/g' setup_sqlchop_proxy.sh
sed -i 's/domain.com/'${domain}'/g' setup_sqlchop_proxy.sh
sed -i 's/project_name/'${project}'/g' setup_lets_encrypt.sh
sed -i 's/domain.com/'${domain}'/g' setup_lets_encrypt.sh

cd $PWD/../

sed -i 's/project_name/'${project}'/g' Dockerfile
sed -i 's/project_name/'${project}'/g' http_nginx.conf;
sed -i 's/domain.com/'${domain}'/g' http_nginx.conf;
sed -i 's/project_name/'${project}'/g' https_nginx.conf;
sed -i 's/domain.com/'${domain}'/g' https_nginx.conf;

sed -i 's/domain.com/'${domain}'/g' config/email.yml
sed -i 's/domain.com/'${domain}'/g' config/environments/production.rb

test -e .env && echo "The file '.env' exist, now exit." && exit 0
touch .env
echo -e "SECRET_KEY_BASE=${secret}" > .env

sudo chgrp 9999 /run/docker.sock

echo -e "All Done!"