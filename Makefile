
VERSION=v2
TARGETDIR=/usr/local
SRCDIR=`pwd`/$(VERSION)
FILES= db_mstart db_transition db_saveall db_config db_savetable db_loadfileto

install:
	@echo "SRCDIR $(SRCDIR)"
	-$(foreach f, $(FILES), rm -f  $(TARGETDIR)/bin/$(f))
	-rm -f $(TARGETDIR)/etc/db/config.master.conf
	-ln -s $(SRCDIR)/db_mstart      	$(TARGETDIR)/bin/db_mstart
	-ln -s $(SRCDIR)/db_transition  	$(TARGETDIR)/bin/db_transition
	-ln -s $(SRCDIR)/db_saveall     	$(TARGETDIR)/bin/db_saveall
	-ln -s $(SRCDIR)/db_config 		$(TARGETDIR)/bin/db_config
	-ln -s $(SRCDIR)/db_savetable 	$(TARGETDIR)/bin/db_savetable
	-ln -s $(SRCDIR)/db_loadfileto 	$(TARGETDIR)/bin/db_loadfileto
	-mkdir -p $(TARGETDIR)/etc/db
	-ln -s $(SRCDIR)/config.master.conf $(TARGETDIR)/etc/db/config.master.conf

