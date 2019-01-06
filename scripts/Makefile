
SCRIPTS_DIR=$(abspath $(dir $(lastword $(MAKEFILE_LIST))))
EDAPACK_BUILD_DIR=$(abspath $(SCRIPTS_DIR)/..)
TOOLS_DIR=$(EDAPACK_BUILD_DIR)/tools
BUILD_DIR=$(EDAPACK_BUILD_DIR)/build
PACKAGES_DIR=$(EDAPACK_BUILD_DIR)/packages

GNU_MIRROR_URL ?= http://mirrors.kernel.org/gnu

BINUTILS_VERSION=2.30
BINUTILS_DIR=binutils-$(BINUTILS_VERSION)
BINUTILS_TBZ=$(BINUTILS_DIR).tar.bz2
BINUTILS_URL=$(GNU_MIRROR_URL)/binutils/$(BINUTILS_TBZ)

CMAKE_VERSION=3.13.2
CMAKE_DIR=cmake-$(CMAKE_VERSION)-Linux-x86_64
CMAKE_TGZ=$(CMAKE_DIR).tar.gz
CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v$(CMAKE_VERSION)/$(CMAKE_TGZ)

BISON_VERSION=3.2.4
BISON_DIR=bison-$(BISON_VERSION)
BISON_TXZ=$(BISON_DIR).tar.xz
BISON_URL=$(GNU_MIRROR_URL)/bison/$(BISON_TXZ)

GCC_VERSION=4.8.5
GCC_DIR=gcc-$(GCC_VERSION)
GCC_TGZ=$(GCC_DIR).tar.gz
GCC_URL=$(GNU_MIRROR_URL)/gcc/$(GCC_DIR)/$(GCC_TGZ)

GMP_VERSION=6.1.0
GMP_DIR=gmp-$(GMP_VERSION)
GMP_TBZ=$(GMP_DIR).tar.bz2
GMP_URL=$(GNU_MIRROR_URL)/gmp/$(GMP_TBZ)

MPFR_VERSION=3.1.4
MPFR_DIR=mpfr-$(MPFR_VERSION)
MPFR_TBZ=$(MPFR_DIR).tar.bz2
MPFR_URL=$(GNU_MIRROR_URL)/mpfr/$(MPFR_TBZ)

MPC_VERSION=1.0.3
MPC_DIR=mpc-$(MPC_VERSION)
MPC_TGZ=$(MPC_DIR).tar.gz
MPC_URL=$(GNU_MIRROR_URL)/mpc/$(MPC_TGZ)

PYTHON_VERSION_MAJOR=3.6
PYTHON_VERSION=$(PYTHON_VERSION_MAJOR).8
PYTHON_DIR=Python-$(PYTHON_VERSION)
PYTHON_TXZ=$(PYTHON_DIR).tar.xz
PYTHON_URL=https://www.python.org/ftp/python/$(PYTHON_VERSION)/$(PYTHON_TXZ)

ifeq (true,$(VERBOSE))
Q=
WGET=wget
TARV=v
else
Q=@
TARV=
WGET=wget -q
endif

UNTARBZ=tar x$(TARV)jf
UNTARGZ=tar x$(TARV)zf
UNTARXZ=tar x$(TARV)Jf

PATH:=$(TOOLS_DIR)/$(GCC_DIR)/bin:$(TOOLS_DIR)/python3/bin:$(PATH)
export PATH

all : tools

tools : $(BUILD_DIR)/tools.d

$(BUILD_DIR)/tools.d : \
		$(BUILD_DIR)/gcc.d \
		$(BUILD_DIR)/bison.d \
		$(BUILD_DIR)/python.d \
		$(BUILD_DIR)/cmake.d
	$(Q)touch $@


$(BUILD_DIR)/gcc.d : \
	$(PACKAGES_DIR)/$(GCC_TGZ) \
	$(PACKAGES_DIR)/$(GMP_TBZ) \
	$(PACKAGES_DIR)/$(MPFR_TBZ) \
	$(PACKAGES_DIR)/$(MPC_TGZ)
	$(Q)rm -rf $(BUILD_DIR)/gcc
	$(Q)mkdir -p $(BUILD_DIR)/gcc
	$(Q)cd $(BUILD_DIR)/gcc ; $(UNTARGZ) $(PACKAGES_DIR)/$(GCC_TGZ)
	$(Q)cd $(BUILD_DIR)/gcc ; $(UNTARBZ) $(PACKAGES_DIR)/$(GMP_TBZ)
	$(Q)cd $(BUILD_DIR)/gcc ; mv $(GMP_DIR) $(GCC_DIR)/gmp
	$(Q)cd $(BUILD_DIR)/gcc ; $(UNTARGZ) $(PACKAGES_DIR)/$(MPC_TGZ)
	$(Q)cd $(BUILD_DIR)/gcc ; mv $(MPC_DIR) $(GCC_DIR)/mpc
	$(Q)cd $(BUILD_DIR)/gcc ; $(UNTARBZ) $(PACKAGES_DIR)/$(MPFR_TBZ)
	$(Q)cd $(BUILD_DIR)/gcc ; mv $(MPFR_DIR) $(GCC_DIR)/mpfr
	$(Q)cd $(BUILD_DIR)/gcc/$(GCC_DIR) ; \
		./configure --prefix=$(TOOLS_DIR)/gcc-4.8.5 \
			--enable-languages=c,c++
	$(Q)cd $(BUILD_DIR)/gcc/$(GCC_DIR) ; $(MAKE)
	$(Q)cd $(BUILD_DIR)/gcc/$(GCC_DIR) ; $(MAKE) install
	$(Q)touch $@

$(PACKAGES_DIR)/$(BINUTILS_TBZ) :
	$(Q)mkdir -p $(PACKAGES_DIR)
	$(Q)$(WGET) -O $@ $(BINUTILS_URL)

$(PACKAGES_DIR)/$(GCC_TGZ) :
	$(Q)mkdir -p $(PACKAGES_DIR)
	$(Q)$(WGET) -O $@ $(GCC_URL)
 
$(PACKAGES_DIR)/$(GMP_TBZ) :
	$(Q)mkdir -p $(PACKAGES_DIR)
	$(Q)$(WGET) -O $@ $(GMP_URL)

$(PACKAGES_DIR)/$(MPC_TGZ) :
	$(Q)mkdir -p $(PACKAGES_DIR)
	$(Q)$(WGET) -O $@ $(MPC_URL)

$(PACKAGES_DIR)/$(MPFR_TBZ) :
	$(Q)mkdir -p $(PACKAGES_DIR)
	$(Q)$(WGET) -O $@ $(MPFR_URL)

$(BUILD_DIR)/python.d : $(PACKAGES_DIR)/$(PYTHON_TXZ)
	$(Q)rm -rf $(BUILD_DIR)/python
	$(Q)mkdir -p $(BUILD_DIR)/python
	$(Q)cd $(BUILD_DIR)/python ; $(UNTARXZ) $^
	$(Q)cd $(BUILD_DIR)/python/$(PYTHON_DIR) ; \
		./configure --prefix=$(TOOLS_DIR)/python3
	$(Q)cd $(BUILD_DIR)/python/$(PYTHON_DIR); $(MAKE)
	$(Q)cd $(BUILD_DIR)/python/$(PYTHON_DIR); $(MAKE) install
	$(Q)touch $@

$(PACKAGES_DIR)/$(PYTHON_TXZ) :
	$(Q)if test ! -d $(PACKAGES_DIR); then mkdir -p $(PACKAGES_DIR); fi
	$(Q)$(WGET) -O $@ $(PYTHON_URL)

$(BUILD_DIR)/bison.d : $(PACKAGES_DIR)/$(BISON_TXZ)
	$(Q)rm -rf $(BUILD_DIR)/bison
	$(Q)mkdir -p $(BUILD_DIR)/bison
	$(Q)cd $(BUILD_DIR)/bison ; $(UNTARXZ) $(PACKAGES_DIR)/$(BISON_TXZ)
	$(Q)cd $(BUILD_DIR)/bison/$(BISON_DIR) ; \
		./configure --prefix=$(TOOLS_DIR)/bison
	$(Q)cd $(BUILD_DIR)/bison/$(BISON_DIR) ; $(MAKE)
	$(Q)cd $(BUILD_DIR)/bison/$(BISON_DIR) ; $(MAKE) install
	$(Q)touch $@

$(PACKAGES_DIR)/$(BISON_TXZ) :
	$(Q)if test ! -d $(PACKAGES_DIR); then mkdir -p $(PACKAGES_DIR); fi
	$(Q)$(WGET) -O $@ $(BISON_URL)

$(BUILD_DIR)/cmake.d : $(PACKAGES_DIR)/$(CMAKE_TGZ)
	$(Q)rm -rf $(BUILD_DIR)/cmake
	$(Q)mkdir -p $(BUILD_DIR)/cmake
	$(Q)rm -rf $(TOOLS_DIR)/cmake
	$(Q)cd $(BUILD_DIR)/cmake ; $(UNTARGZ) $(PACKAGES_DIR)/$(CMAKE_TGZ)
	$(Q)mv $(BUILD_DIR)/cmake/$(CMAKE_DIR) $(TOOLS_DIR)/cmake
	$(Q)touch $@
	
$(PACKAGES_DIR)/$(CMAKE_TGZ) : 
	$(Q)mkdir -p $(PACKAGES_DIR)
	$(Q)$(WGET) -O $@ $(CMAKE_URL)
