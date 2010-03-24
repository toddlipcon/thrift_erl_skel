THRIFT_RPCS=SKEL_SHORTNAME
THRIFT_MODULES=SKEL_ERLANGIFIED_LONGNAME
RPC_DIR=../../if

EBIN=ebin
ESRC=src

include ../build/otp.mk
include ../build/colors.mk
include ../build/buildtargets.mk


INTERNAL_HRL_FILES=$(THRIFT_RPCS:%=%_types.hrl) $(THRIFT_MODULES:%=%_thrift.hrl)
HRL_FILES=
MODULES=$(THRIFT_RPCS:%=%_types) $(THRIFT_MODULES:%=%_thrift)
ERL_FILES= $(MODULES:%=src/%.erl)
DOC_FILES=$(ERL_FILES)

BEAMS= $(MODULES:%=$(EBIN)/%.$(EMULATOR))
TARGET_FILES= $(BEAMS)

all: gensrc $(EBIN) $(TARGET_FILES)
	echo $(TARGET_FILES)

src:
	mkdir -p src
	mkdir -p include
	mkdir -p timestamps

$(ESRC)/%_types.erl include/%_types.hrl: $(RPC_DIR)/%.thrift
	thrift -gen erl $<
	mv gen-erl/*erl src/
	mv gen-erl/*hrl include/
	rmdir gen-erl

$(THRIFT_MODULES:%=$(ESRC)/%_thrift.erl):

gensrc: src $(ERL_FILES)

# ----------------------------------------------------
# FLAGS
# ----------------------------------------------------

ERL_FLAGS +=
ERL_COMPILE_FLAGS += -Iinclude

# ----------------------------------------------------
# Targets
# ----------------------------------------------------

#$(EBIN)/rm_logger.beam: $(APP_NAME).hrl
include ../build/docs.mk

# Note: In the open-source build clean must not destroy the preloaded
# beam files.
clean:
	rm -Rf src/
	rm -Rf timestamps/
	rm -f $(TARGET_FILES)
	rm -f *~
	rm -f core
	rm -rf $(EBIN)
	rm -rf *html

$(EBIN):
	mkdir $(EBIN)
