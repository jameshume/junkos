################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../JunkOS/src/junkos_scheduler.c 

OBJS += \
./JunkOS/src/junkos_scheduler.o 

C_DEPS += \
./JunkOS/src/junkos_scheduler.d 


# Each subdirectory must supply rules for building sources it contributes
JunkOS/src/%.o JunkOS/src/%.su: ../JunkOS/src/%.c JunkOS/src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DSTM32 -DSTM32F401RETx -DSTM32F4 -c -I../Inc -I"/home/james/STM32CubeIDE/Play/Play1/stm32f401ret6_chip_headers/CMSIS/Include" -I"/home/james/STM32CubeIDE/Play/Play1/stm32f401ret6_chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -I"/home/james/STM32CubeIDE/Play/Play1/JunkOS/inc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-JunkOS-2f-src

clean-JunkOS-2f-src:
	-$(RM) ./JunkOS/src/junkos_scheduler.d ./JunkOS/src/junkos_scheduler.o ./JunkOS/src/junkos_scheduler.su

.PHONY: clean-JunkOS-2f-src

