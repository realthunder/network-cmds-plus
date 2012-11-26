# Copyright (c) 2012, Zheng Lei
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met: 
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution. 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies, 
# either expressed or implied, of the FreeBSD Project.

PKG_NAME=network_cmds
PKG_URL=http://opensource.apple.com/tarballs/$(PKG_NAME)
PKG_VERSION=396.6
PKG_DIR=$(PKG_NAME)-$(PKG_VERSION)
PKG_FILE=$(PKG_DIR).tar.gz
PKG_MD5=dddb06d61504031bf8071f53ed7c1d0b

all: network_cmds

include ../../common.mk

network_cmds: $(PKG_PATCHED)
	if ! (cd $(PKG_SRCDIR) && xcodebuild -target All -sdk iphoneos5.1 -configuration Release install DSTROOT=$(DIST_DIR)); then\
		echo "failed to build network_cmds";\
		exit 1;\
	fi

clean:
	cd $(PKG_SRCDIR) && xcodebuild -target All -sdk iphoneos5.1 -configuration Release clean

