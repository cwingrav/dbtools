
VERSION=v2
TARGETDIR=/usr/local
SRCDIR=`pwd`/$(VERSION)
FILES= db_mstart db_transition db_saveall db_config

install:
	@echo "SRCDIR $(SRCDIR)"
	-$(foreach f, $(FILES), rm -f  $(TARGETDIR)/bin/$(f))
	-rm -f $(TARGETDIR)/etc/db/config.master.conf
	ln -s $(SRCDIR)/db_mstart      $(TARGETDIR)/bin/db_mstart
	ln -s $(SRCDIR)/db_transition  $(TARGETDIR)/bin/db_transition
	ln -s $(SRCDIR)/db_saveall     $(TARGETDIR)/bin/db_saveall
	ln -s $(SRCDIR)/db_config $(TARGETDIR)/bin/db_config
	-mkdir -p $(TARGETDIR)/etc/db
	ln -s $(SRCDIR)/config.master.conf $(TARGETDIR)/etc/db/config.master.conf

