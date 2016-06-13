#!/bin/bash
#  
# Publishes nightly builds of gsnotes
# 
#     http://notes.harpending.org
# 
# FreeBSD License
# 
# Copyright (c) 2016, Peter Harpending <peter.harpending@utah.edu>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# Copied from here:
# https://raw.githubusercontent.com/learnyou/nightly/master/nightly.sh

cleanup () {
    cd
    rm -rf gsnotes 
}

# Filename
GS_EBOOK=`date -u +"gsnotes-nightly-ebook-%Y-%m-%d.pdf"`
GS_PRINT=`date -u +"gsnotes-nightly-print-%Y-%m-%d.pdf"`
# Where things are stored
GSDIR=/usr/share/nginx/notes.harpending.org/math4400
# Start in home directory
cd
# Clone repo
git clone git://github.com/pharpend/gsnotes.git
cd gsnotes
# If nothing changed today, exit
if [[ `git whatchanged --since='24 hours ago'` == "" ]] ; then
    cleanup
    exit 0
fi
# Else, build
make
# Move things
cp gsnotes-ebook.pdf ${GSDIR}/${GS_EBOOK}
cp gsnotes-print.pdf ${GSDIR}/${GS_PRINT}
cd ${GSDIR}
ln -sf ${GS_EBOOK} gsnotes-current-ebook.pdf
ln -sf ${GS_PRINT} gsnotes-current-print.pdf
# Die
cleanup
