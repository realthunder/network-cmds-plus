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

PKG_NAME=radvd
PKG_URL=http://www.litech.org/radvd/dist
PKG_VERSION=1.8.5
PKG_DIR=$(PKG_NAME)-$(PKG_VERSION)
PKG_FILE=$(PKG_DIR).tar.gz
PKG_MD5=bdeca76d976282c306f3c454d6ff1f67
PKG_CONFIG=export EXTRA_CFLAGS='-DPRIVATE=1 -DUSE_RFC2292BIS=1 -D__APPLE_USE_RFC_3542=1 -I/System/Library/Frameworks/System.framework/PrivateHeaders'

all: radvd

include ../../common.mk

radvd: $(PKG_CONFIGED)
	make -C $(PKG_SRCDIR) install

clean:
	[ -d $(PKG_SRCDIR) ] && make -C $(PKG_SRCDIR) clean

