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

PKG_CURDIR=$(CURDIR)
ROOT_DIR=$(PKG_CURDIR)/../..
SRC_DIR=$(ROOT_DIR)/build
DOWNLOAD_DIR=$(ROOT_DIR)/dl
DIST_DIR=$(ROOT_DIR)/dist
PKG_SRCDIR=$(SRC_DIR)/$(PKG_DIR)

PKG_DOWNLOADED=$(PKG_SRCDIR)/.$(PKG_NAME).downloaded
PKG_PATCHED=$(PKG_SRCDIR)/.$(PKG_NAME).patched
PKG_CONFIGED=$(PKG_SRCDIR)/.$(PKG_NAME).configed

define Download
	if [ "$(PKG_URL)" != "" ]; then\
		mkdir -p $(DOWNLOAD_DIR) $(SRC_DIR);\
		DW_OUT=$(DOWNLOAD_DIR)/$(PKG_FILE);\
		if [ ! -f $$DW_OUT ] || [ `md5 -q $$DW_OUT` != "$(PKG_MD5)" ]; then\
			if ! curl $(PKG_URL)/$(PKG_FILE) -o $$DW_OUT; then\
				echo "failed to download $(PKG_FILE)"; \
				exit 1;\
			fi;\
		fi;\
		if [ "$(PKG_MD5)" != "" ] && [ "`md5 -q $$DW_OUT`" != "$(PKG_MD5)" ]; then \
			echo "$(PKG_FILE) md5 mismatch";\
			exit 1;\
		elif ! tar xf $$DW_OUT -C $(SRC_DIR); then\
			echo "failed to extract $(PKG_FILE)";\
			exit 1;\
		elif [ ! -d $(PKG_SRCDIR) ]; then \
			echo "cannot find $(PKG_DIR) after extracting $(PKG_FILE)";\
			exit 1;\
		fi; \
	fi;\
	touch $(PKG_DOWNLOADED)
endef

define Patch
	if [ -d $(PKG_CURDIR)/patches ]; then\
		for f in $(PKG_CURDIR)/patches/* ; do \
			if [ "$${f%.patch}" != "$$f" ]; then \
				if ! (cd $(PKG_SRCDIR) && patch -p1 < $$f); then\
					echo "failed to apply patch $$f";\
					exit 1;\
				fi;\
			elif [ "$${f%.sh}" != "$$f" ]; then \
				if ! ../$$f; then\
					echo "failed to apply patch $$f";\
					exit 1;\
				fi;\
			else\
				echo "Unknown patch file $$f";\
				exit 1;\
			fi;\
		done;\
	fi;\
	touch $(PKG_PATCHED)
endef

define Config
	cd $(PKG_SRCDIR);\
	if [ -f configure ]; then\
		$(PKG_CONFIG);\
		if ! $(ROOT_DIR)/scripts/configure-ios -l -p $(DIST_DIR) device7; then\
			echo "radvd configure failed";\
			exit 1;\
		fi;\
	fi;\
	touch $(PKG_CONFIGED)
endef

$(PKG_DOWNLOADED):
	$(call Download)

$(PKG_PATCHED): $(PKG_DOWNLOADED)
	$(call Patch)

$(PKG_CONFIGED): $(PKG_PATCHED)
	$(call Config)

pkg.cleanall:
	rm -rf $(PKG_SRCDIR)
