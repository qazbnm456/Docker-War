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
PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# if [[ "$EUID" != "0" ]]; then
#   echo "[!] This script must be run as root." 1>&2
#   exit 1
# fi

# Global config variables
DOMAIN="domain.com"
DB_DIR="/home/app/db"
NGINX_PROXY="lobsiinvok_nginx-proxy"
MYSQL="lobsiinvok_mysql"
VPS="ctf-tools" # https://github.com/zardus/ctf-tools

while getopts "n:s:f:b:i:p:d" OPTION; do
    case $OPTION in
        n)
            NAME=$OPTARG
            ;;
        s)
            SUBDOMAIN=$OPTARG
            ;;
        f)
            FLAG=$OPTARG
            ;;
        p)
            NUM=$OPTARG
            echo "[*] Passing PORT: "$NUM
            docker run -d -p $NUM:80 --name $NAME -e IDENTITY_NAME=$DOMAIN -e IDENTITY_REGEX="^"+$NAME+"$" -v /var/run/docker.sock:/tmp/docker.sock:ro $NGINX_PROXY
            echo "[*] Creating VPS..."
            docker run -d -it --label $DOMAIN="$NAME" --name "VPS"_"$NAME" $VPS
            ;;
        b)
            DB=$OPTARG
            echo "[*] Passing DB: "$DB
            ;;
        i)
            IMAGE=$OPTARG
            echo "[*] Passing IMAGE: "$IMAGE
            OUT="$(docker ps | grep "^$SUBDOMAIN"_"$NAME$" | wc -l | awk '{print $1}' ORS='')"
            if [[ "$OUT" == "0" ]]; then
                if [[ "$DB" == "" ]]; then
                    docker run \
                        -d \
                        -e TEMPLATE_NGINX_HTML=1 \
                        -e VIRTUAL_HOST=$SUBDOMAIN.$DOMAIN \
                        -e FLAG="$FLAG" \
                        --label $DOMAIN="$NAME" \
                        --name "$SUBDOMAIN"_"$NAME" \
                        $IMAGE
                else
                    case $DB in
                        mysql)
                            docker run \
                                -d \
                                -e MYSQL_ROOT_PASSWORD=toor \
                                -e MYSQL_USER=Docker-War \
                                -e MYSQL_PASSWORD=Docker-War \
                                -e MYSQL_DATABASE=$IMAGE \
                                -e FLAG=$FLAG \
                                --name "$SUBDOMAIN"_"$NAME"_"$DB" \
                                $MYSQL;
                            docker cp \
                                $DB_DIR/$IMAGE/$IMAGE.sql \
                                "$SUBDOMAIN"_"$NAME"_"$DB":/docker-entrypoint-initdb.d/
                            docker run -d \
                                -e TEMPLATE_NGINX_HTML=1 \
                                -e VIRTUAL_HOST=$SUBDOMAIN.$DOMAIN \
                                -e DBHOST="$SUBDOMAIN"_"$NAME"_"$DB" \
                                -e FLAG="$FLAG" \
                                --link "$SUBDOMAIN"_"$NAME"_"$DB":$MYSQL \
                                --label $DOMAIN="$NAME" \
                                --name "$SUBDOMAIN"_"$NAME" \
                                $IMAGE;
                        ;;
                    esac
                fi
            fi
            ;;
        d)
            echo "[*] Deleting..."
            docker rm -f `docker ps -a | grep "$NAME$" | awk '{print $1}' ORS=' '`
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done
