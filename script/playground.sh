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

cd script/

export RANCHER_URL=$RANCHER_URL
export RANCHER_ACCESS_KEY=$RANCHER_ACCESS_KEY
export RANCHER_SECRET_KEY=$RANCHER_SECRET_KEY

export DOMAIN=domain.com
export DB_DIR=/home/app/db
export NGINX_PROXY=lobsiinvok_nginx-proxy
export MYSQL=lobsiinvok_mysql
export VPS=ctf-tools
export SPAWNER=muctf-spawner

while getopts "n:s:f:b:i:p:d" OPTION; do
    case $OPTION in
        n)
            export NAME=$OPTARG
            ;;
        s)
            export SUBDOMAIN=$OPTARG
            ;;
        f)
            export FLAG=$OPTARG
            ;;
        p)
            export NUM=$OPTARG
            echo "[*] Creating PROXY"
            rancher-compose -p "stack-"$NAME"-stack" up -d proxy
            echo "[*] Creating VPS"
            rancher-compose -p "stack-"$NAME"-stack" up -d vps
            echo "[*] Creating SPAWNER"
            rancher-compose -p "stack-"$NAME"-stack" up -d spawner
            ;;
        b)
            export DB=$OPTARG
            echo "[*] Passing DB: "$DB
            ;;
        i)
            export IMAGE=$OPTARG
            echo "[*] Passing IMAGE: "$IMAGE
            if [[ "$DB" == "" ]]; then
                rancher-compose -p "stack-"$NAME"-stack" up -d $IMAGE
            else
                case $DB in
                    mysql)
                        rancher-compose -p "stack-"$NAME"-stack" up -d $IMAGE"-mysql"
                        rancher-compose -p "stack-"$NAME"-stack" up -d $IMAGE
                    ;;
                esac
            fi
            ;;
        d)
            echo "[*] Deleting Containers"
            rancher-compose -p "stack-"$NAME"-stack" rm -f
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done
