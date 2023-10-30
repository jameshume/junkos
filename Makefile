CC:=arm-none-eabi-gcc 

SOURCES:=                           \
	JunkOS/src/junkos_scheduler.c   \
	Src/main.c                      \
	Startup/startup_stm32f401retx.s 

OBJECTS:=$(patsubst %.s,%.o,$(patsubst %.c,%.o,$(SOURCES)))

CC_WARNINGS:=                \
	-Werror                  \
	-Wall                    \
	-Wextra                  \
	-Wshadow                 \
	-Wcast-align             \
	-Wpointer-arith          \
	-Wmisleading-indentation \
	-Wuninitialized          \
	-pedantic                \
	-Wconversion             \
	-Wsign-conversion

## TODO make this work!
DEPS:=$(patsubst %.o,%.d,$(OBJECTS))

%.o: %.s
	@echo Building $<
	@mkdir --parents "built/$(dir $<)"
	@$(CC) \
		-mcpu=cortex-m4 \
		-g3 \
		-DDEBUG \
		-c  \
		-x assembler-with-cpp \
		-MMD -MP -MF"$(@:%.o=built/%.d)" -MT"$(@:%=built/%)" \
		--specs=nano.specs \
		-mfpu=fpv4-sp-d16 \
		-mfloat-abi=hard \
		-mthumb \
		-o "built/$(dir $<)$(patsubst %.s,%.o,$(notdir $<))"             \
		"$<"

%.o: %.c
	@echo Building $<
	@mkdir --parents "built/$(dir $<)"
	@$(CC)                                                               \
	    -nostdlib                                                        \
		-ffreestanding                                                   \
		-mcpu=cortex-m4                                                  \
		-std=gnu11                                                       \
		-g3                                                              \
		-DDEBUG -DSTM32 -DSTM32F401RETx -DSTM32F4                        \
		-c                                                               \
		-I"Inc"                                                          \
		-I"stm32f401ret6_chip_headers/CMSIS/Include"                     \
		-I"stm32f401ret6_chip_headers/CMSIS/Device/ST/STM32F4xx/Include" \
		-I"JunkOS/inc"                                                   \
		-O0                                                              \
		-ffunction-sections                                              \
		-fdata-sections                                                  \
		$(CC_WARNINGS)                                                   \
		-fstack-usage                                                    \
		-MMD -MP -MF"$(@:%.o=built/%.d)" -MT"$(@:%=built/%)"             \
		--specs=nano.specs                                               \
		-mfpu=fpv4-sp-d16                                                \
		-mfloat-abi=hard                                                 \
		-mthumb                                                          \
		-o "built/$(dir $<)$(patsubst %.c,%.o,$(notdir $<))"             \
		"$<"

.PHONY: all
all: $(OBJECTS)
	@echo "Linking JunkOS.elf"
	@$(CC)                             \
		-nostdlib                      \
		-ffreestanding                 \
		-o "built/JunkOS.elf"          \
		$(addprefix built/,$(OBJECTS)) \
		-mcpu=cortex-m4                \
		-T"STM32F401RETX_FLASH.ld"     \
		--specs=nosys.specs            \
		-Wl,-Map="JunkOSApp.map"       \
		-Wl,--gc-sections              \
		-static                        \
		--specs=nano.specs             \
		-mfpu=fpv4-sp-d16              \
		-mfloat-abi=hard               \
		-mthumb -Wl,--start-group -lc -lm -Wl,--end-group

.PHONY: clean
clean:
	@rm -fr built