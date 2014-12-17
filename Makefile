#
# file: Makefile
#
# Makefile for whole project, just a proxy for nuttx/Makefile or tup, with some additional logic
#
# chip: STM32F401RE
#
# author: Freddie Chopin, http://www.freddiechopin.info http://www.distortec.com
# date: 2014-12-17
#

ifeq ($(OS),Windows_NT)
	# Windows format, but with forward slashes
	PWD := "pwd -W"
else
	PWD := "pwd"
endif

TOPDIR := "${shell echo `$(PWD)`}/nuttx"

all: nuttx/.config nuttx/Make.defs
	$(MAKE) -C nuttx V=1 TOPDIR=$(TOPDIR)
	@echo ' '
	@echo "Creating extended listing nuttx.lss..."
	arm-none-eabi-objdump --demangle -S nuttx/nuttx > nuttx/nuttx.lss 
	@echo ' '
	arm-none-eabi-size -B nuttx/nuttx

clean:
	$(MAKE) -C nuttx clean

clean_context:
	$(MAKE) -C nuttx clean_context

distclean:
	$(MAKE) -C nuttx distclean

nuttx/.config: nuttx/configs/nucleo-f4x1re/f401-nsh/defconfig
	cp $< nuttx/.config

nuttx/Make.defs: nuttx/configs/nucleo-f4x1re/f401-nsh/Make.defs
	cp $< nuttx/Make.defs

.PHONY: all clean clean_context distclean
