#!/bin/bash

#    The Star And Thank Author License (SATA)
#
#    Copyright (c) 2014-2016 Boik Su (boik@tdohacker.org)
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

protoc -h >/dev/null 2>&1 || { echo >&2 "Protoc is needed but I cannot find that. Aborting."; exit 1; }
node -h >/dev/null 2>&1 || { echo >&2 "Node is needed but I cannot find that. Aborting."; exit 1; }
npm -h >/dev/null 2>&1 || { echo >&2 "Npm is needed but I cannot find that. Aborting."; exit 1; }

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $PWD && curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install protobuf==3.0.0b2

npm install -g node-gyp && npm install -g forever

cd $PWD \
    && git clone https://github.com/qazbnm456/sqlchop-http-proxy \
    && cd sqlchop-http-proxy && npm install --unsafe-perm \
    && forever start \
        -l /home/app/project_name/log/access.log \
        -e /home/app/project_name/log/error.log \
        -f \
        server.js "http://localhost"