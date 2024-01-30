PREFIX?=/usr/local
INSTALL?=install
INSTALL_PROGRAM?=$(INSTALL) -s
INSTALL_DEST?=$(DESTDIR)$(PREFIX)/lib/pd/extra/gendy~
INSTALL_DATA?=$(INSTALL) -m 644

CXX_FLAGS?=-I/usr/include/pd -Iflext/source -DFLEXT_SYS=2 -DNDEBUG -fPIC -fvisibility-inlines-hidden -ffunction-sections -fdata-sections -O3
LD_FLAGS?=-Wl,--gc-sections

.PHONY: clean install

SOURCES_CPP = $(wildcard src/*.cpp)

SOURCES_CPP += \
	flext/source/flatom.cpp \
	flext/source/flatom_part.cpp \
	flext/source/flatom_pr.cpp \
	flext/source/flattr.cpp \
	flext/source/flattr_ed.cpp \
	flext/source/flbase.cpp \
	flext/source/flbind.cpp \
	flext/source/flbuf.cpp \
	flext/source/fldsp.cpp \
	flext/source/flext.cpp \
	flext/source/flitem.cpp \
	flext/source/fllib.cpp \
	flext/source/flmap.cpp \
	flext/source/flmeth.cpp \
	flext/source/flmsg.cpp \
	flext/source/flout.cpp \
	flext/source/flproxy.cpp \
	flext/source/flqueue.cpp \
	flext/source/flsimd.cpp \
	flext/source/flsupport.cpp \
	flext/source/flthr.cpp \
	flext/source/fltimer.cpp \
	flext/source/flutil.cpp \
	flext/source/flxlet.cpp

OBJECTS = $(SOURCES_CPP:.cpp=.o)

%.o: %.cpp
	$(CXX) -c -o $@ $^ $(CXX_FLAGS)

gendy~.pd_linux: $(OBJECTS)
	$(CXX) -shared -o $@ $^ $(LD_FLAGS)

install: gendy~.pd_linux gendy-ex1.pd gendy-gui.pd gendy~-help.pd
	mkdir -p $(INSTALL_DEST)
	$(INSTALL_PROGRAM) gendy~.pd_linux $(INSTALL_DEST)
	$(INSTALL_DATA) gendy-ex1.pd gendy-gui.pd gendy~-help.pd $(INSTALL_DEST)

clean:
	rm -f $(OBJECTS) gendy~.pd_linux

all: gendy~.pd_linux
