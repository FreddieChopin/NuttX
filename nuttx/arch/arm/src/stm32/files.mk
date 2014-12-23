#
# file: nuttx/arch/arm/src/stm32/files.mk
#
# List of files with full path (relative to nuttx/arch/arm/src) for build of libarch.a. It is meant to be included by
# both make and tup
#
# author: Freddie Chopin, http://www.freddiechopin.info http://www.distortec.com
# date: 2014-12-23
#

ifeq ($(CONFIG_ARMV7M_CMNVECTOR),y)
HEAD_ASRC =
else
HEAD_ASRC = stm32/stm32_vectors.S
endif

CMN_UASRCS =
CMN_UCSRCS =

CMN_ASRCS  = armv7-m/up_saveusercontext.S armv7-m/up_fullcontextrestore.S armv7-m/up_switchcontext.S
CMN_ASRCS += armv7-m/vfork.S

CMN_CSRCS  = armv7-m/up_assert.c armv7-m/up_blocktask.c armv7-m/up_copyfullstate.c
CMN_CSRCS += common/up_createstack.c common/up_mdelay.c common/up_udelay.c common/up_exit.c
CMN_CSRCS += common/up_initialize.c armv7-m/up_initialstate.c common/up_interruptcontext.c
CMN_CSRCS += armv7-m/up_memfault.c common/up_modifyreg8.c common/up_modifyreg16.c common/up_modifyreg32.c
CMN_CSRCS += armv7-m/up_releasepending.c common/up_releasestack.c armv7-m/up_reprioritizertr.c
CMN_CSRCS += armv7-m/up_schedulesigaction.c armv7-m/up_sigdeliver.c common/up_stackframe.c
CMN_CSRCS += armv7-m/up_systemreset.c armv7-m/up_unblocktask.c common/up_usestack.c armv7-m/up_doirq.c
CMN_CSRCS += armv7-m/up_hardfault.c armv7-m/up_svcall.c common/up_vfork.c

ifeq ($(CONFIG_ARMV7M_CMNVECTOR),y)
CMN_ASRCS += armv7-m/up_exception.S
CMN_CSRCS += armv7-m/up_vectors.c
endif

ifeq ($(CONFIG_ARCH_RAMVECTORS),y)
CMN_CSRCS += armv7-m/up_ramvec_initialize.c armv7-m/up_ramvec_attach.c
endif

ifeq ($(CONFIG_ARCH_MEMCPY),y)
CMN_ASRCS += armv7-m/up_memcpy.S
endif

ifeq ($(CONFIG_BUILD_PROTECTED),y)
CMN_CSRCS += armv7-m/up_mpu.c common/up_task_start.c common/up_pthread_start.c
ifneq ($(CONFIG_DISABLE_SIGNALS),y)
CMN_CSRCS += armv7-m/up_signal_dispatch.c
CMN_UASRCS += armv7-m/up_signal_handler.S
endif
endif

ifeq ($(CONFIG_DEBUG_STACK),y)
CMN_CSRCS += common/up_checkstack.c
endif

ifeq ($(CONFIG_ELF),y)
CMN_CSRCS += armv7-m/up_elf.c
endif

ifeq ($(CONFIG_ARCH_FPU),y)
CMN_ASRCS += armv7-m/up_fpu.S
ifneq ($(CONFIG_ARMV7M_CMNVECTOR),y)
CMN_CSRCS += armv7-m/up_copyarmstate.c
endif
endif

CHIP_ASRCS  =

CHIP_CSRCS  = stm32/stm32_allocateheap.c stm32/stm32_start.c stm32/stm32_rcc.c stm32/stm32_lse.c
CHIP_CSRCS += stm32/stm32_lsi.c stm32/stm32_gpio.c stm32/stm32_exti_gpio.c stm32/stm32_flash.c stm32/stm32_irq.c
CHIP_CSRCS += stm32/stm32_dma.c stm32/stm32_lowputc.c stm32/stm32_serial.c stm32/stm32_spi.c
CHIP_CSRCS += stm32/stm32_sdio.c stm32/stm32_tim.c stm32/stm32_waste.c stm32/stm32_ccm.c

ifneq ($(CONFIG_SCHED_TICKLESS),y)
CHIP_CSRCS += stm32/stm32_timerisr.c
endif

ifeq ($(CONFIG_ARMV7M_CMNVECTOR),y)
CHIP_ASRCS += stm32/stm32_vectors.S
endif

ifeq ($(CONFIG_BUILD_PROTECTED),y)
CHIP_CSRCS += stm32/stm32_userspace.c stm32/stm32_mpuinit.c
endif

ifeq ($(CONFIG_STM32_CCM_PROCFS),y)
CHIP_CSRCS += stm32/stm32_procfs_ccm.c
endif

ifeq ($(CONFIG_STM32_I2C_ALT),y)
CHIP_CSRCS += stm32/stm32_i2c_alt.c
else
ifeq ($(CONFIG_STM32_STM32F30XX),y)
CHIP_CSRCS += stm32/stm32f30xxx_i2c.c
else
CHIP_CSRCS += stm32/stm32_i2c.c
endif
endif

ifeq ($(CONFIG_USBDEV),y)
ifeq ($(CONFIG_STM32_USB),y)
CHIP_CSRCS += stm32/stm32_usbdev.c
endif
ifeq ($(CONFIG_STM32_OTGFS),y)
CHIP_CSRCS += stm32/stm32_otgfsdev.c
endif
ifeq ($(CONFIG_STM32_OTGHS),y)
CHIP_CSRCS += stm32/stm32_otghsdev.c
endif
endif

ifeq ($(CONFIG_USBHOST),y)
ifeq ($(CONFIG_STM32_OTGFS),y)
CHIP_CSRCS += stm32/stm32_otgfshost.c
endif
ifeq ($(CONFIG_STM32_OTGHS),y)
CHIP_CSRCS += stm32/stm32_otghshost.c
endif
endif

ifeq ($(CONFIG_USBHOST),y)
ifeq ($(CONFIG_USBHOST_TRACE),y)
CHIP_CSRCS += stm32/stm32_usbhost.c
else
ifeq ($(CONFIG_DEBUG_USB),y)
CHIP_CSRCS += stm32/stm32_usbhost.c
endif
endif
endif

ifneq ($(CONFIG_ARCH_IDLE_CUSTOM),y)
CHIP_CSRCS += stm32/stm32_idle.c
endif

CHIP_CSRCS += stm32/stm32_pmstop.c stm32/stm32_pmstandby.c stm32/stm32_pmsleep.c

ifneq ($(CONFIG_ARCH_CUSTOM_PMINIT),y)
CHIP_CSRCS += stm32/stm32_pminitialize.c
endif

ifeq ($(CONFIG_STM32_ETHMAC),y)
CHIP_CSRCS += stm32/stm32_eth.c
endif

ifeq ($(CONFIG_STM32_PWR),y)
CHIP_CSRCS += stm32/stm32_pwr.c
endif

ifeq ($(CONFIG_RTC),y)
CHIP_CSRCS += stm32/stm32_rtc.c
ifeq ($(CONFIG_RTC_ALARM),y)
CHIP_CSRCS += stm32/stm32_exti_alarm.c
endif
endif

ifeq ($(CONFIG_ADC),y)
CHIP_CSRCS += stm32/stm32_adc.c
endif

ifeq ($(CONFIG_DAC),y)
CHIP_CSRCS += stm32/stm32_dac.c
endif

ifeq ($(CONFIG_DEV_RANDOM),y)
CHIP_CSRCS += stm32/stm32_rng.c
endif

ifeq ($(CONFIG_STM32_LTDC),y)
CHIP_CSRCS += stm32/stm32_ltdc.c
endif

ifeq ($(CONFIG_PWM),y)
CHIP_CSRCS += stm32/stm32_pwm.c
endif

ifeq ($(CONFIG_QENCODER),y)
CHIP_CSRCS += stm32/stm32_qencoder.c
endif

ifeq ($(CONFIG_CAN),y)
CHIP_CSRCS += stm32/stm32_can.c
endif

ifeq ($(CONFIG_STM32_IWDG),y)
CHIP_CSRCS += stm32/stm32_iwdg.c
endif

ifeq ($(CONFIG_STM32_WWDG),y)
CHIP_CSRCS += stm32/stm32_wwdg.c
endif

ifeq ($(CONFIG_DEBUG),y)
CHIP_CSRCS += stm32/stm32_dumpgpio.c
endif
