FLEXT ?= flext-build.sh
PREFIX?=/usr/local
INSTALL?=install
INSTALL_PROGRAM?=$(INSTALL) -s
INSTALL_DIR?=$(DESTDIR)$(PREFIX)/pd/extra/gendy~
INSTALL_DATA?=$(INSTALL) -m 644

.PHONY: clean install

gendy~.pd_linux:
	$(FLEXT) pd gcc build
	cp -p pd-linux/release-single/gendy~.pd_linux .

install: gendy~.pd_linux gendy-ex1.pd gendy-gui.pd gendy~-help.pd
	mkdir -p $(INSTALL_DIR)
	$(INSTALL_PROGRAM) gendy~.pd_linux $(INSTALL_DIR)
	$(INSTALL_DATA) gendy-ex1.pd gendy-gui.pd gendy~-help.pd $(INSTALL_DIR)

clean:
	$(FLEXT) pd gcc clean
	rm -f gendy~.pd_linux

all: gendy~.pd_linux
