#!/bin/bash

#    The Star And Thank Author License (SATA)
#    
#    Copyright (c) 2014-2016 Boik Su (lobsiinvok@tdohacker.org)
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

PREREQUISITIES_IMAGES=(lobsiinvok_nginx-proxy richarvey/nginx-php-fpm lampe/minimal-nginx)

if docker version 2> /dev/null 1>&2; then
    echo -e "\e[0;32m Docker works!\e[0m";
    for i in "${PREREQUISITIES_IMAGES[@]}"; do
        ret="$(docker images | grep "${i}"| wc -l)"
        if [[ "$ret" == "0" ]]; then
            case ${i} in
                lobsiinvok_nginx-proxy)
                    echo -e "\e[0;31m IMAGE: \"${i}\" not found!\e[0m You may find it on \e[0;34mhttps://github.com/qazbnm456/nginx-proxy\e[0m";
                    ;;
                richarvey/nginx-php-fpm)
                    echo -e "\e[0;31m IMAGE: \"${i}\" not found!\e[0m";
                    echo -e "\e[0;43m Trying to fetch from docker hub...\e[0m";
                    docker pull ${i}
                    echo -e "\e[0;43m ${i} downloaded!\e[0m";
                    ;;
                lampe/minimal-nginx)
                    echo -e "\e[0;31m IMAGE: \"${i}\" not found!\e[0m";
                    echo -e "\e[0;43m Trying to fetch from docker hub...\e[0m";
                    docker pull ${i}
                    echo -e "\e[0;43m ${i} downloaded!\e[0m";
                    ;;
                \?)
                    echo -e "\e[0;31m IMAGE: \"${i}\" not found!\e[0m You may find it on \e[0;34mhttps://github.com/qazbnm456\e[0m";
                    ;;
            esac
        fi
    done
else
    echo -e "\e[0;31m Docker not found!\e[0m";
fi
